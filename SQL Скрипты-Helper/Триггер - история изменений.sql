insert into dbo.TipTur_History(TT_WHEN, TT_WHO, TT_MOD, TT_TPKEY, TT_LAST_NAME, TT_NEW_NAME)
    
	select getdate(),
	user
	,case WHEN i.tp_key is null then 'delete' when d.tp_key is null then 'insert' else 'update' end
	,isnull(i.tp_key, d.tp_key)
	,d.TP_NAME
	,i.TP_NAME
	from inserted i full join deleted d on i.tp_key = d.tp_key
