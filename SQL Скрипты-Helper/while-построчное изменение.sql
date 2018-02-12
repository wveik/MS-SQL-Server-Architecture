declare
    @cnt int while 1=1
begin
    
    select --*
           min(TUR_DATE) as 'min'
         , max(TUR_DATE) as 'max'
    from
           tbl_name (nolock)
           --update TOP (50) tbl_name set PARTNERKEY = 59193
    where
           1           =1
           and dl_svkey=1
           and DL_PAKETKEY in ( 1
                             , 2
                             , 3
                             , 4 )
           and CODE in ( 1
                      , 2 )
           and PARTNERKEY = 14006
           --and TUR_DATE='20170603'
           
           --order by TUR_DATE
           
           set @cnt = @@rowcount if @cnt<=0 break
end