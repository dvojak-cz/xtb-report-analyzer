CREATE TABLE closed_positions (
    id             INTEGER not null
        constraint table_name_pk
            primary key autoincrement,
    position       INTEGER not null,
    symbol         TEXT,
    type           integer not null,
    volume         REAL    not null,
    open_time      INTEGER not null,
    open_price     REAL,
    close_time     INTEGER not null,
    close_price    INTEGER,
    open_origin    TEXT,
    close_origin   TEXT,
    purchase_value REAL    not null,
    sale_value     REAL    not null,
    sl             TEXT,
    tp             TEXT,
    margin         TEXT,
    commission     TEXT,
    swap           TEXT,
    rollover       TEXT,
    gross_pl       TEXT,
    comment        TEXT
);

CREATE TABLE open_positions
(
    id             INTEGER not null
        constraint table_name_pk
            primary key autoincrement,
    position       INTEGER not null,
    symbol         TEXT,
    type           integer not null,
    volume         REAL    not null,
    open_time      INTEGER not null,
    open_price     REAL,
    market_price   REAL,
    purchase_value REAL    not null,
    sl             TEXT,
    tp             TEXT,
    margin         TEXT,
    commission     TEXT,
    swap           TEXT,
    rollover       TEXT,
    gross_pl       TEXT,
    comment        TEXT
);

CREATE TABLE pending_orders
(
    id             INTEGER not null
        constraint table_name_pk
            primary key autoincrement,
    id2            INTEGER not null,
    symbol         TEXT,
    purchase_value REAL    not null,
    nominal_value  REAL    not null,
    price          REAL    not null,
    margin         REAL,
    type           integer not null,
    "order"          TEXT,
    side           TEXT,
    sl             TEXT,
    tp             TEXT,
    open_time      INTEGER not null
);

CREATE TABLE cash_operations
(
    id      INTEGER not null
        constraint table_name_pk
            primary key autoincrement,
    id2     INTEGER not null,
    type    INTEGER not null,
    time    INTEGER not null,
    comment TEXT,
    symbol  TEXT,
    amount  REAL    not null
);

CREATE TABLE balance_operations
(
    id      INTEGER not null
        constraint table_name_pk
            primary key autoincrement,
    id2     INTEGER not null,
    type    INTEGER not null,
    time    INTEGER not null,
    comment TEXT,
    amount  REAL    not null
);