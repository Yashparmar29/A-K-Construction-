package com.akconstruction.service;

import com.akconstruction.model.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.List;
import java.util.Map;

@Service
public class PdfService {

    public byte[] generatePlanPdf(PropertyDetail pd, HousePlan hp, CostEstimation ce, MaterialEstimation me, String base64Image) {
        Document document = new Document(PageSize.A4, 36, 36, 54, 36);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        try {
            PdfWriter writer = PdfWriter.getInstance(document, baos);
            
            // Add header/footer events
            writer.setPageEvent(new PdfHeaderFooterEventHandler());

            document.open();

            // Fonts
            BaseColor primaryColor = new BaseColor(184, 134, 11); // Gold/Bronze
            BaseColor darkGray = new BaseColor(45, 45, 45);
            BaseColor lightGray = new BaseColor(245, 245, 245);

            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 22, primaryColor);
            Font subtitleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, darkGray);
            Font sectionHeaderFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, primaryColor);
            Font boldFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, darkGray);
            Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 10, darkGray);
            Font smallFont = FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 8, BaseColor.RED);
            Font footerFont = FontFactory.getFont(FontFactory.HELVETICA, 8, BaseColor.GRAY);

            // 1. HEADER (Title Block)
            Paragraph header = new Paragraph();
            header.setAlignment(Element.ALIGN_CENTER);
            header.add(new Chunk("A K CONSTRUCTION\n", titleFont));
            header.add(new Chunk("AI Smart House Planning & Estimation Report\n", subtitleFont));
            header.add(new Chunk("___________________________________________________________________\n\n", boldFont));
            document.add(header);

            // 2. CUSTOMER & PROPERTY DETAILS
            Paragraph detailsHeader = new Paragraph("CUSTOMER & SITE INFORMATION", sectionHeaderFont);
            detailsHeader.setSpacingAfter(8);
            document.add(detailsHeader);

            PdfPTable detailsTable = new PdfPTable(2);
            detailsTable.setWidthPercentage(100);
            detailsTable.setSpacingAfter(20);

            // Styling helper for table cells
            addTableCell(detailsTable, "Owner Name:", pd.getOwnerName(), boldFont, normalFont, lightGray);
            addTableCell(detailsTable, "Email Address:", pd.getEmail(), boldFont, normalFont, lightGray);
            addTableCell(detailsTable, "Phone Number:", pd.getPhone(), boldFont, normalFont, lightGray);
            addTableCell(detailsTable, "Site Address:", pd.getCity() + ", " + pd.getState() + ", " + pd.getCountry(), boldFont, normalFont, lightGray);
            addTableCell(detailsTable, "Plot Dimensions:", (int)pd.getLength() + " ft × " + (int)pd.getWidth() + " ft", boldFont, normalFont, lightGray);
            addTableCell(detailsTable, "Total Plot Area:", (int)pd.getPlotArea() + " sq ft", boldFont, normalFont, lightGray);
            addTableCell(detailsTable, "Number of Floors:", String.valueOf(pd.getFloors()), boldFont, normalFont, lightGray);
            addTableCell(detailsTable, "Required Bedrooms:", String.valueOf(pd.getBedrooms()), boldFont, normalFont, lightGray);
            addTableCell(detailsTable, "Required Bathrooms:", String.valueOf(pd.getBathrooms()), boldFont, normalFont, lightGray);
            addTableCell(detailsTable, "Kitchen Style:", pd.getKitchenType(), boldFont, normalFont, lightGray);
            addTableCell(detailsTable, "Architectural Style:", pd.getStyle(), boldFont, normalFont, lightGray);
            addTableCell(detailsTable, "Vastu Compliant:", pd.getVastu(), boldFont, normalFont, lightGray);

            document.add(detailsTable);

            // 3. AI HOUSE LAYOUT RECOMMENDATIONS
            Paragraph recHeader = new Paragraph("AI LAYOUT & SPATIAL PLANNING SUGGESTIONS", sectionHeaderFont);
            recHeader.setSpacingAfter(8);
            document.add(recHeader);

            Paragraph recText = new Paragraph(hp.getRecommendations(), normalFont);
            recText.setSpacingAfter(20);
            document.add(recText);

            // 4. ROOM LAYOUT DETAILS
            Paragraph layoutHeader = new Paragraph("ROOM DIMENSIONS BREAKDOWN", sectionHeaderFont);
            layoutHeader.setSpacingAfter(8);
            document.add(layoutHeader);

            PdfPTable layoutTable = new PdfPTable(3);
            layoutTable.setWidthPercentage(100);
            layoutTable.setWidths(new float[]{30f, 40f, 30f});
            layoutTable.setSpacingAfter(20);

            // Header Row
            PdfPCell cell1 = new PdfPCell(new Paragraph("Floor", boldFont));
            cell1.setBackgroundColor(lightGray);
            cell1.setPadding(6);
            PdfPCell cell2 = new PdfPCell(new Paragraph("Allocated Room", boldFont));
            cell2.setBackgroundColor(lightGray);
            cell2.setPadding(6);
            PdfPCell cell3 = new PdfPCell(new Paragraph("Dimensions (Width × Length)", boldFont));
            cell3.setBackgroundColor(lightGray);
            cell3.setPadding(6);
            
            layoutTable.addCell(cell1);
            layoutTable.addCell(cell2);
            layoutTable.addCell(cell3);

            try {
                ObjectMapper mapper = new ObjectMapper();
                Map<String, List<String>> floors = mapper.readValue(hp.getFloorDetails(), Map.class);
                Map<String, String> dimensions = mapper.readValue(hp.getRoomDimensions(), Map.class);

                for (Map.Entry<String, List<String>> entry : floors.entrySet()) {
                    String floorName = entry.getKey();
                    List<String> rooms = entry.getValue();
                    for (String room : rooms) {
                        String dim = dimensions.get(room);
                        if (dim == null) dim = "As required";
                        else dim = dim + " ft";
                        
                        layoutTable.addCell(new Paragraph(floorName, normalFont));
                        layoutTable.addCell(new Paragraph(room, normalFont));
                        layoutTable.addCell(new Paragraph(dim, normalFont));
                    }
                }
            } catch (Exception e) {
                // Fallback if JSON parsing fails
                layoutTable.addCell(new Paragraph("General Layout", normalFont));
                layoutTable.addCell(new Paragraph("All Rooms", normalFont));
                layoutTable.addCell(new Paragraph("Dimensions detailed on website dashboard", normalFont));
            }

            document.add(layoutTable);

            // Add Page Break to put Cost and 3D Model on Next Page
            document.newPage();

            // 5. 3D HOUSE MODEL CANVAS PREVIEW (if image exists)
            if (base64Image != null && !base64Image.isEmpty()) {
                Paragraph previewHeader = new Paragraph("3D CONCEPTUAL HOUSE PREVIEW", sectionHeaderFont);
                previewHeader.setSpacingAfter(8);
                document.add(previewHeader);

                try {
                    String cleanBase64 = base64Image.replace("data:image/png;base64,", "");
                    byte[] imageBytes = Base64.getDecoder().decode(cleanBase64);
                    Image img = Image.getInstance(imageBytes);
                    img.scaleToFit(400f, 250f);
                    img.setAlignment(Element.ALIGN_CENTER);
                    img.setSpacingAfter(20);
                    document.add(img);
                } catch (Exception e) {
                    System.err.println("Could not add Three.js preview image to PDF: " + e.getMessage());
                }
            }

            // 6. CONSTRUCTION COST BREAKDOWN
            Paragraph costHeader = new Paragraph("ESTIMATED CONSTRUCTION COST BREAKDOWN", sectionHeaderFont);
            costHeader.setSpacingAfter(8);
            document.add(costHeader);

            PdfPTable costTable = new PdfPTable(2);
            costTable.setWidthPercentage(100);
            costTable.setSpacingAfter(20);

            addTableCell(costTable, "Foundation Work:", String.format("Rs. %,.2f", ce.getFoundationCost()), boldFont, normalFont, lightGray);
            addTableCell(costTable, "Wall & Structural Construction:", String.format("Rs. %,.2f", ce.getWallCost()), boldFont, normalFont, lightGray);
            addTableCell(costTable, "Roofing Slab & Beam Work:", String.format("Rs. %,.2f", ce.getRoofCost()), boldFont, normalFont, lightGray);
            addTableCell(costTable, "Electrical Installations:", String.format("Rs. %,.2f", ce.getElectricalCost()), boldFont, normalFont, lightGray);
            addTableCell(costTable, "Plumbing & Drainage:", String.format("Rs. %,.2f", ce.getPlumbingCost()), boldFont, normalFont, lightGray);
            addTableCell(costTable, "Flooring Finish:", String.format("Rs. %,.2f", ce.getFlooringCost()), boldFont, normalFont, lightGray);
            addTableCell(costTable, "Painting & Coatings:", String.format("Rs. %,.2f", ce.getPaintingCost()), boldFont, normalFont, lightGray);
            addTableCell(costTable, "Interior Design Mockup:", String.format("Rs. %,.2f", ce.getInteriorCost()), boldFont, normalFont, lightGray);
            addTableCell(costTable, "Labor Wages & Supervision:", String.format("Rs. %,.2f", ce.getLaborCost()), boldFont, normalFont, lightGray);
            
            PdfPCell totalLabelCell = new PdfPCell(new Paragraph("TOTAL ESTIMATED BUDGET:", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, primaryColor)));
            totalLabelCell.setBackgroundColor(new BaseColor(230, 240, 250));
            totalLabelCell.setPadding(6);
            PdfPCell totalValCell = new PdfPCell(new Paragraph(String.format("Rs. %,.2f", ce.getTotalCost()), FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, primaryColor)));
            totalValCell.setBackgroundColor(new BaseColor(230, 240, 250));
            totalValCell.setPadding(6);
            costTable.addCell(totalLabelCell);
            costTable.addCell(totalValCell);

            document.add(costTable);

            // 7. MATERIAL RECOMMENDATION
            Paragraph materialHeader = new Paragraph("RECOMMENDED CONSTRUCTION MATERIALS", sectionHeaderFont);
            materialHeader.setSpacingAfter(8);
            document.add(materialHeader);

            PdfPTable matTable = new PdfPTable(2);
            matTable.setWidthPercentage(100);
            matTable.setSpacingAfter(20);

            addTableCell(matTable, "Cement Bags Required:", me.getCementBags() + " bags (50kg each)", boldFont, normalFont, lightGray);
            addTableCell(matTable, "Steel Reinforcement:", String.format("%,.1f kg", me.getSteelKg()), boldFont, normalFont, lightGray);
            addTableCell(matTable, "Clay Bricks / Blocks:", me.getBricksPcs() + " pcs", boldFont, normalFont, lightGray);
            addTableCell(matTable, "Fine Sand:", String.format("%,.1f cft (Cubic Feet)", me.getSandCft()), boldFont, normalFont, lightGray);
            addTableCell(matTable, "Coarse Aggregate:", String.format("%,.1f cft", me.getAggregateCft()), boldFont, normalFont, lightGray);
            addTableCell(matTable, "Interior & Exterior Paint:", String.format("%,.1f Liters", me.getPaintLiters()), boldFont, normalFont, lightGray);
            addTableCell(matTable, "Flooring Tiles Area:", String.format("%,.1f sq ft", me.getTilesSqft()), boldFont, normalFont, lightGray);

            document.add(matTable);

            // 8. CONSTRUCTION TIMELINE
            Paragraph timelineHeader = new Paragraph("ESTIMATED CONSTRUCTION TIMELINE", sectionHeaderFont);
            timelineHeader.setSpacingAfter(8);
            document.add(timelineHeader);

            PdfPTable timelineTable = new PdfPTable(3);
            timelineTable.setWidthPercentage(100);
            timelineTable.setWidths(new float[]{15f, 40f, 45f});
            timelineTable.setSpacingAfter(25);

            timelineTable.addCell(new PdfPCell(new Paragraph("Phase", boldFont)));
            timelineTable.addCell(new PdfPCell(new Paragraph("Timeline", boldFont)));
            timelineTable.addCell(new PdfPCell(new Paragraph("Major Operations", boldFont)));

            timelineTable.addCell(new Paragraph("Phase 1", normalFont));
            timelineTable.addCell(new Paragraph("Weeks 1 - 4", normalFont));
            timelineTable.addCell(new Paragraph("Site clearing, excavation, foundation footing, and plinth beam.", normalFont));

            timelineTable.addCell(new Paragraph("Phase 2", normalFont));
            timelineTable.addCell(new Paragraph("Weeks 5 - 12", normalFont));
            timelineTable.addCell(new Paragraph("RCC pillars, columns, wall brickwork structure, slab and beam casting.", normalFont));

            timelineTable.addCell(new Paragraph("Phase 3", normalFont));
            timelineTable.addCell(new Paragraph("Weeks 13 - 18", normalFont));
            timelineTable.addCell(new Paragraph("Concealed electrical wiring, plumbing, and wall cement plastering.", normalFont));

            timelineTable.addCell(new Paragraph("Phase 4", normalFont));
            timelineTable.addCell(new Paragraph("Weeks 19 - 24", normalFont));
            timelineTable.addCell(new Paragraph("Tile flooring, wall painting, electrical fixtures, utility setup, final touch.", normalFont));

            document.add(timelineTable);

            // 9. DISCLAIMER (Important Legal Text)
            Paragraph disclaimerHeader = new Paragraph("LEGAL DISCLAIMER & TERMS", sectionHeaderFont);
            disclaimerHeader.setSpacingAfter(4);
            document.add(disclaimerHeader);

            Paragraph disclaimer = new Paragraph(
                "IMPORTANT NOTICE: The house plans, room allocations, spatial dimensions, material estimations, and cost predictions generated in this report are for conceptual planning assistance only. This report does not represent builder construction designs, architectural drafts, or structural engineering solutions. Before initiating any earthwork or construction, these specifications must be reviewed, verified, and approved by a licensed professional architect and structural engineer in your jurisdiction. A K Construction accepts no liability for actions taken based on this conceptual layout.",
                smallFont
            );
            disclaimer.setSpacingAfter(10);
            document.add(disclaimer);

            // 10. CONTACT INFORMATION
            Paragraph contactInfo = new Paragraph(
                "A K Construction | 123 Construction Ave, Gujarat, India 380001 | Phone: +91 98765 43210 | Email: info@akconstruction.com",
                footerFont
            );
            contactInfo.setAlignment(Element.ALIGN_CENTER);
            document.add(contactInfo);

            document.close();
        } catch (DocumentException e) {
            System.err.println("DocumentException during PDF creation: " + e.getMessage());
        }

        return baos.toByteArray();
    }

    private void addTableCell(PdfPTable table, String label, String value, Font boldFont, Font normalFont, BaseColor bg) {
        PdfPCell labelCell = new PdfPCell(new Paragraph(label, boldFont));
        labelCell.setPadding(5);
        labelCell.setBorder(Rectangle.BOTTOM);
        labelCell.setBorderColor(BaseColor.LIGHT_GRAY);
        
        PdfPCell valCell = new PdfPCell(new Paragraph(value, normalFont));
        valCell.setPadding(5);
        valCell.setBorder(Rectangle.BOTTOM);
        valCell.setBorderColor(BaseColor.LIGHT_GRAY);

        table.addCell(labelCell);
        table.addCell(valCell);
    }

    // Page Event Handler for running headers/footers
    private static class PdfHeaderFooterEventHandler extends PdfPageEventHelper {
        @Override
        public void onEndPage(PdfWriter writer, Document document) {
            PdfContentByte cb = writer.getDirectContent();
            Phrase footer = new Phrase("Page " + writer.getPageNumber() + " | Conceptual Planning Assistance | A K Construction", 
                FontFactory.getFont(FontFactory.HELVETICA, 8, BaseColor.GRAY));
            
            ColumnText.showTextAligned(cb, Element.ALIGN_CENTER,
                footer,
                (document.right() - document.left()) / 2 + document.leftMargin(),
                document.bottom() - 15, 0);
        }
    }
}
