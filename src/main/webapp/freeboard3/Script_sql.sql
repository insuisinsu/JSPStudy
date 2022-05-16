--게시판 만들기

create table freeboard (
    id number constraint PK_freeboard_id Primary key, --자동 증가 컬럼
    name varchar2(10) not null,
    password varchar2(100) null,
    email varchar2(100) null,
    subject varchar2(100) not null,     -- 제목
    content varchar2(2000) not null,       -- 본문
    inputdate varchar2(100) not null,       -- 작성일
    masterid number default 0,          -- 질문 답변형 게시판에서 답변의 글을 그룹핑 할 때 사용
    readcount number default 0,         -- 조회수
    replaynum number default 0,         -- 
    step number default 0
);
select * from freeboard