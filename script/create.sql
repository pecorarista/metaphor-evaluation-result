drop table if exists results cascade;

create table results (
    metric text,
    noun text,
    verb text,
    vote int,
    user_id text,
    primary key (noun, verb, metric, user_id)
)
