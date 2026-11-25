#!/usr/bin/env python3
"""Build SETUP.pdf from SETUP.md.  Usage: python3 documentation/build_pdf.py

Supports the small Markdown subset the guide uses: # headings, paragraphs,
- bullets, 1. numbered lists, ``` code blocks, | tables |, `code`, **bold**.
Needs ReportLab (sudo apt install python3-reportlab, or pip install reportlab).
"""
import re
from pathlib import Path

from reportlab.lib import colors
from reportlab.lib.enums import TA_LEFT
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import mm
from reportlab.platypus import (ListFlowable, ListItem, Paragraph,
                                Preformatted, SimpleDocTemplate, Spacer, Table,
                                TableStyle)

HERE = Path(__file__).resolve().parent
SOURCE, TARGET = HERE / 'SETUP.md', HERE / 'SETUP.pdf'

INK, ACCENT, MUTED = colors.HexColor('#1f2937'), colors.HexColor('#1d4ed8'), colors.HexColor('#6b7280')
CODE_BG, RULE, HEAD_BG = colors.HexColor('#f3f4f6'), colors.HexColor('#d1d5db'), colors.HexColor('#e8eefc')

base = getSampleStyleSheet()
S = {
    'title': ParagraphStyle('title', parent=base['Title'], textColor=INK, fontSize=22,
                            leading=27, alignment=TA_LEFT, spaceAfter=4),
    'h2': ParagraphStyle('h2', parent=base['Heading2'], textColor=ACCENT, fontSize=14,
                         leading=18, spaceBefore=12, spaceAfter=5, keepWithNext=1),
    'h3': ParagraphStyle('h3', parent=base['Heading3'], textColor=INK, fontSize=11.5,
                         leading=15, spaceBefore=8, spaceAfter=4, keepWithNext=1),
    'body': ParagraphStyle('body', parent=base['BodyText'], textColor=INK, fontSize=9.8,
                           leading=13.6, spaceAfter=5),
    'cell': ParagraphStyle('cell', parent=base['BodyText'], textColor=INK, fontSize=8.6,
                           leading=11),
    'code': ParagraphStyle('code', fontName='Courier', fontSize=8.4, leading=11,
                           textColor=INK),
}


def inline(text: str) -> str:
    """Escape XML, then turn `code` and **bold** into ReportLab markup."""
    text = text.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
    text = re.sub(r'`([^`]+)`', r'<font face="Courier" color="#b91c1c">\1</font>', text)
    return re.sub(r'\*\*([^*]+)\*\*', r'<b>\1</b>', text)


def table(rows, width):
    cells = [[c.strip() for c in r.strip().strip('|').split('|')] for r in rows]
    cells = [r for r in cells if not all(re.fullmatch(r':?-+:?', c) for c in r)]
    data = [[Paragraph(('<b>%s</b>' if i == 0 else '%s') % inline(c), S['cell'])
             for c in row] for i, row in enumerate(cells)]
    t = Table(data, colWidths=[width / len(cells[0])] * len(cells[0]), repeatRows=1)
    t.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), HEAD_BG),
        ('GRID', (0, 0), (-1, -1), 0.4, RULE),
        ('VALIGN', (0, 0), (-1, -1), 'TOP'),
        ('TOPPADDING', (0, 0), (-1, -1), 3), ('BOTTOMPADDING', (0, 0), (-1, -1), 3),
    ]))
    return [t, Spacer(1, 8)]


def build():
    lines = SOURCE.read_text().splitlines()
    doc = SimpleDocTemplate(str(TARGET), pagesize=A4, title='Vyuh Blueprint Project: Development Setup Guide',
                            leftMargin=18 * mm, rightMargin=18 * mm,
                            topMargin=18 * mm, bottomMargin=18 * mm)
    story, i, para = [], 0, []

    def flush():
        if para:
            story.append(Paragraph(inline(' '.join(para)), S['body']))
            para.clear()

    while i < len(lines):
        line = lines[i]
        if line.startswith('```'):
            flush()
            j = i + 1
            while not lines[j].startswith('```'):
                j += 1
            box = Table([[Preformatted('\n'.join(lines[i + 1:j]), S['code'])]],
                        colWidths=[doc.width])
            box.setStyle(TableStyle([('BACKGROUND', (0, 0), (-1, -1), CODE_BG),
                                     ('BOX', (0, 0), (-1, -1), 0.4, RULE),
                                     ('LEFTPADDING', (0, 0), (-1, -1), 8),
                                     ('TOPPADDING', (0, 0), (-1, -1), 6),
                                     ('BOTTOMPADDING', (0, 0), (-1, -1), 6)]))
            story += [Spacer(1, 2), box, Spacer(1, 8)]
            i = j + 1
            continue
        if line.startswith('|'):
            flush()
            j = i
            while j < len(lines) and lines[j].startswith('|'):
                j += 1
            story += table(lines[i:j], doc.width)
            i = j
            continue
        bullet = re.match(r'^(- |\d+\. )(.*)', line)
        if bullet:
            flush()
            numbered, items = bullet.group(1)[0].isdigit(), []
            while i < len(lines) and re.match(r'^(- |\d+\. )', lines[i]):
                items.append(ListItem(Paragraph(inline(re.sub(r'^(- |\d+\. )', '', lines[i])),
                                                S['body']), leftIndent=14))
                i += 1
            story.append(ListFlowable(items, bulletType='1' if numbered else 'bullet',
                                      start='1' if numbered else None, leftIndent=14,
                                      bulletFontSize=9))
            continue
        if line.startswith('# '):
            flush()
            story.append(Paragraph(inline(line[2:]), S['title']))
            story.append(Spacer(1, 4))
        elif line.startswith('## '):
            flush()
            story.append(Paragraph(inline(line[3:]), S['h2']))
        elif line.startswith('### '):
            flush()
            story.append(Paragraph(inline(line[4:]), S['h3']))
        elif not line.strip():
            flush()
        else:
            para.append(line.strip())
        i += 1
    flush()

    def footer(canvas, d):
        canvas.saveState()
        canvas.setFont('Helvetica', 8)
        canvas.setFillColor(MUTED)
        canvas.drawString(18 * mm, 10 * mm, 'Development Setup Guide')
        canvas.drawRightString(A4[0] - 18 * mm, 10 * mm, f'Page {d.page}')
        canvas.restoreState()

    doc.build(story, onFirstPage=footer, onLaterPages=footer)
    print(f'Wrote {TARGET.relative_to(HERE.parent)}')


if __name__ == '__main__':
    build()
