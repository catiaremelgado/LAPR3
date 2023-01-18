create or replace function fncListarEncomenda( idStatus number) return SYS_REFCURSOR as
  result SYS_REFCURSOR;
begin
    if(testar_IdStatus(idStatus) = 1) then
        open result for Select data_pedido_Enc, codigo_interno_Clt_fk, ID_Enc_pk
            from Encomenda e where idStatus = e.ID_EstEnc_fk;

    end if;
    return result;
end;

create or replace function testar_IdStatus (idStatus number) return number
IS
    lidStatus number;
BEGIN
    if(lidStatus > 5 or lidStatus < 1) then
        return 1;
    else
        return 0;
    end if;
EXCEPTION
    WHEN OTHERS THEN
    return 0;
END;
