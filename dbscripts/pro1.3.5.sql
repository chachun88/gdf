ALTER TABLE "Order_Detail" ADD COLUMN moved boolean DEFAULT false;
ALTER TABLE "Order_Detail" DROP CONSTRAINT order_detail_order;
ALTER TABLE "Order_Detail" DROP CONSTRAINT order_detail_product;
ALTER TABLE "Order_Detail" ADD CONSTRAINT order_detail_order FOREIGN KEY (order_id)
      REFERENCES "Order" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Order_Detail" ADD CONSTRAINT order_detail_product FOREIGN KEY (product_id)
      REFERENCES "Product" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
UPDATE "Order_Detail" SET moved = true;