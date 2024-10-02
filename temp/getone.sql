SELECT
    -- Campos do artigo 
    `art_id`, `art_title`, `art_content`
    -- Campos do author
    sta_id, sta_name, sta_image, sta_description, st_type
    -- Campos expeciais 
    -- Converter a data do artigo para PT-BR
    DATE FORMAT(art_date, '%d/%m/%Y às %H:%i') AS art_datebr
FROM article 
-- Junção das tabelas `article` e `staff`
INNER JOIN staff ON art_author = sta_id
-- Filtros 
WHERE art_id = '6'
    AND art_status = 'on'
    AND art_date <= NOW()