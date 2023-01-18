create or replace trigger atualização_colt
after update
    of data_hora_efetivo_RgtColh
        on Registo_Colheita
for each row
begin
    update  Operacao
    set data_hora_efetivo_Op = :new.data_hora_efetivo_RgtColh
    where ID_Prcl_ck = :old.Id_Prcl_ck and ID_Cult_ck = :old.ID_Cult_ck and data_Plant_ck = :old.data_Plant_ck and data_hora_previsto_Op_ck = :old.data_hora_previsto_RgtColh_ck;
end;