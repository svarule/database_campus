   
      WITH 
      CTE_VENDOR as (
 SELECT i.vendor_id, MAX(invoice_total) AS largest_unpaid_invoice, v.vendor_name
      FROM invoices AS i
      LEFT join vendors AS v
      ON i.vendor_id=v.vendor_id
      WHERE invoice_total - credit_total - payment_total > 0
      GROUP BY vendor_id)
SELECT *
FROM CTE_VENDOR
ORDER BY  vendor_id;

WITH 
      CTE_VENDOR1 as
      (
Select avg(largest_unpaid_invoice) from (
SELECT i.vendor_id, MAX(invoice_total) AS largest_unpaid_invoice, v.vendor_name
      FROM invoices AS i
      LEFT join vendors AS v
      ON i.vendor_id=v.vendor_id
      WHERE invoice_total - credit_total - payment_total > 0
      GROUP BY vendor_id) t  )
SELECT *
FROM CTE_VENDOR1;      


