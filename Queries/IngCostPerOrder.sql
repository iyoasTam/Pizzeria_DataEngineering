--Cost for each ingredient in every order

WITH ingredient_cost AS (
SELECT 
o.item_id,
i.sku,
i.item_name,
r.ing_id,
ing.ing_name,
r.quantity AS recipe_quantity,
sum(o.quantity) AS order_quantity,
ing.ing_weight,
ing.ing_price
FROM
ordersTable o
LEFT JOIN itemTable i
ON o.item_id = i.item_id
LEFT JOIN recipeTable r
ON i.sku = r.recipe_id
LEFT JOIN [dbo].[IngredientTable] ing
ON ing.ing_id = r.ing_id
GROUP BY
o.item_id,
i.sku,
i.item_name,
r.ing_id,
r.quantity,
ing.ing_name,
ing.ing_weight,
ing.ing_price
)

SELECT 	item_name,
		ing_id,
		ing_name,
		ing_weight,
		ing_price,
		order_quantity,
		recipe_quantity,
		order_quantity * recipe_quantity AS ordered_weight,
		ROUND(ing_price/ing_weight , 5) as Unit_cost,
		ROUND((order_quantity*recipe_quantity)*(ing_price/ing_weight), 5) as ingredient_cost

FROM	ingredient_cost
WHERE ing_id IS NOT NULL;