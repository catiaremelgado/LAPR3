create or replace trigger atualização_fert
after update
    of data_hora_efetivo_RgtFert
        on Registo_Fertilizacao
for each row
begin
    update  Operacao
    set data_hora_efetivo_Op = :new.data_hora_efetivo_RgtFert
    where ID_Prcl_ck = :old.Id_Prcl_ck and ID_Cult_ck = :old.ID_Cult_ck and data_Plant_ck = :old.data_Plant_ck and data_hora_previsto_Op_ck = :old.data_hora_previsto_RgtFert_ck;
end;