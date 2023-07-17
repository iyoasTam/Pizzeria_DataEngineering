--To Calculate The Remaining Weight In Our Inventory After An Order

SELECT	sub2.ing_name,
		sub2.ordered_weight,
		ing.ing_weight * inv.quantity as total_inv_weight,
		(ing.ing_weight * inv.quantity)-sub2.ordered_weight as remaining_weight

FROM (
SELECT	CAST(ing_id AS int) AS ing_id,
		ing_name,sum(ordered_weight) as ordered_weight
FROM	stock
--WHERE ing_id IS NOT NULL
GROUP BY ing_id,ing_name
) sub2
	LEFT JOIN inventoryTable inv
		ON inv.item_id = sub2.ing_id
	LEFT JOIN IngredientTable ing
		ON ing.ing_id = sub2.ing_id
WHERE sub2.ing_name IS NOT NULL;