select UNIDADE, MODALIDADE, AGENDA_DESCRICAO, CODIGO_RECURSO_AGENDA from(
select unid_codigo as CODIGO_UNIDADE, unid_reduzido as UNIDADE, clin_descricao as MODALIDADE, recu_descricao as AGENDA_DESCRICAO, recu_codigo as RECURSO,
(
select reca_codigo from recursosagendacad
inner join recursos on recu_codigo = reca_recu_codigo and recu_unid_codigo = reca_codun
where recu_codigo = r.recu_codigo
order by reca_codigo desc
limit 1
) as CODIGO_RECURSO_AGENDA
from recursos r
inner join unidades on recu_unid_codigo = unid_codigo
inner join gruporecursos g on grpr_codigo = recu_grpr_codigo
inner join clinicas c on clin_codigo = grpr_clin_codigo
where recu_ativo = 'S' and unid_codigo = '001'
) as tabela_virtual
inner join recursosagendacfg on recc_reca_codigo = CODIGO_RECURSO_AGENDA and tabela_virtual.CODIGO_UNIDADE = recc_codun
order by UNIDADE, MODALIDADE