-- total number of seats
select distinct count(Parliament_Constituency) as Total_seats from constituencywise_results

-- total number of seats available for election in each state
select states.state, count(Parliament_Constituency) as Seats_Available from states join statewise_results 
on states.State_ID = statewise_results.State_ID 
group by states.State order by Seats_Available  desc

-- total seat won by NDA Alliance
select sum(case when party in(
'Bharatiya Janata Party - BJP', 
'Telugu Desam - TDP',
'Janata Dal  (United) - JD(U)',
'Shiv Sena - SHS', 
'AJSU Party - AJSUP', 
'Apna Dal (Soneylal) - ADAL', 
'Asom Gana Parishad - AGP',
'Hindustani Awam Morcha (Secular) - HAMS', 
'Janasena Party - JnP', 
'Janata Dal  (Secular) - JD(S)',
'Lok Janshakti Party(Ram Vilas) - LJPRV', 
'Nationalist Congress Party - NCP',
'Rashtriya Lok Dal - RLD', 
'Sikkim Krantikari Morcha - SKM')
then [WON] else 0 end) as NDA_won_seats from partywise_results;

-- seats won by its Alliance party
select Party, Won from partywise_results 
where Party in(
'Telugu Desam - TDP',
'Janata Dal  (United) - JD(U)',
'Shiv Sena - SHS', 
'AJSU Party - AJSUP', 
'Apna Dal (Soneylal) - ADAL', 
'Asom Gana Parishad - AGP',
'Hindustani Awam Morcha (Secular) - HAMS', 
'Janasena Party - JnP', 
'Janata Dal  (Secular) - JD(S)',
'Lok Janshakti Party(Ram Vilas) - LJPRV', 
'Nationalist Congress Party - NCP',
'Rashtriya Lok Dal - RLD', 
'Sikkim Krantikari Morcha - SKM') order by Won

-- total seat won by INDIA Alliance
select sum(case when party in(
'Indian National Congress - INC',
'Aam Aadmi Party - AAAP',
'All India Trinamool Congress - AITC',
'Bharat Adivasi Party - BHRTADVSIP',
'Communist Party of India  (Marxist) - CPI(M)',
'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
'Communist Party of India - CPI',
'Dravida Munnetra Kazhagam - DMK',
'Indian Union Muslim League - IUML',
'Nat`Jammu & Kashmir National Conference - JKN',
'Jharkhand Mukti Morcha - JMM',
'Jammu & Kashmir National Conference - JKN',
'Kerala Congress - KEC',
'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
'Rashtriya Janata Dal - RJD',
'Rashtriya Loktantrik Party - RLTP',
'Revolutionary Socialist Party - RSP',
'Samajwadi Party - SP',
'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
'Viduthalai Chiruthaigal Katchi - VCK')
then [WON] else 0 end) as INDIA_won_seats from partywise_results 

-- seats won by its Alliance party
select Party, Won from partywise_results 
where Party in(
'Indian National Congress - INC',
'Aam Aadmi Party - AAAP',
'All India Trinamool Congress - AITC',
'Bharat Adivasi Party - BHRTADVSIP',
'Communist Party of India  (Marxist) - CPI(M)',
'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
'Communist Party of India - CPI',
'Dravida Munnetra Kazhagam - DMK',
'Indian Union Muslim League - IUML',
'Nat`Jammu & Kashmir National Conference - JKN',
'Jharkhand Mukti Morcha - JMM',
'Jammu & Kashmir National Conference - JKN',
'Kerala Congress - KEC',
'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
'Rashtriya Janata Dal - RJD',
'Rashtriya Loktantrik Party - RLTP',
'Revolutionary Socialist Party - RSP',
'Samajwadi Party - SP',
'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
'Viduthalai Chiruthaigal Katchi - VCK') order by Won 

--Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER
alter table partywise_results
add Party_Alliance varchar(50)
update partywise_results 
set Party_Alliance = 'NDA' where Party in(
'Bharatiya Janata Party - BJP', 
'Telugu Desam - TDP',
'Janata Dal  (United) - JD(U)',
'Shiv Sena - SHS', 
'AJSU Party - AJSUP', 
'Apna Dal (Soneylal) - ADAL', 
'Asom Gana Parishad - AGP',
'Hindustani Awam Morcha (Secular) - HAMS', 
'Janasena Party - JnP', 
'Janata Dal  (Secular) - JD(S)',
'Lok Janshakti Party(Ram Vilas) - LJPRV', 
'Nationalist Congress Party - NCP',
'Rashtriya Lok Dal - RLD', 
'Sikkim Krantikari Morcha - SKM')

update partywise_results 
set Party_Alliance= 'INDIA' where Party in(
'Indian National Congress - INC',
'Aam Aadmi Party - AAAP',
'All India Trinamool Congress - AITC',
'Bharat Adivasi Party - BHRTADVSIP',
'Communist Party of India  (Marxist) - CPI(M)',
'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
'Communist Party of India - CPI',
'Dravida Munnetra Kazhagam - DMK',
'Indian Union Muslim League - IUML',
'Jharkhand Mukti Morcha - JMM',
'Jammu & Kashmir National Conference - JKN',
'Kerala Congress - KEC',
'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
'Rashtriya Janata Dal - RJD',
'Rashtriya Loktantrik Party - RLTP',
'Revolutionary Socialist Party - RSP',
'Samajwadi Party - SP',
'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
'Viduthalai Chiruthaigal Katchi - VCK')

update partywise_results 
set Party_Alliance = 'Others' where Party_Alliance is null

--Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?
select Party_Alliance, count(Constituency_ID) as seat_won from partywise_results join constituencywise_results
on partywise_results.Party_ID = constituencywise_results.Party_ID  
group by Party_Alliance order by seat_won desc

--Winning candidate's name, their party name, total votes, and the margin of victory for constituency "AMETHI"?
select constituencywise_results.Winning_Candidate, constituencywise_details.Party,
constituencywise_results.Total_Votes, constituencywise_results.Margin
from constituencywise_details join constituencywise_results on constituencywise_details.Candidate = constituencywise_results.Winning_Candidate
where constituencywise_results.Constituency_Name='AMETHI'

--What is the distribution of EVM votes versus postal votes for candidates in 'MATHURA'?
select cd.Candidate, cd.Party, cd.EVM_Votes, cd.Postal_Votes, cd.Total_Votes, cr.Constituency_Name
from constituencywise_details cd join constituencywise_results cr
on cd.Constituency_ID = cr.Constituency_ID
where cr.Constituency_Name = 'MATHURA'
order by cd.Total_Votes desc

--Which parties won the most seats in Andhra Pradesh, and how many seats did each party win?
select p.Party, count(c.Constituency_ID) as seat_won
from constituencywise_results c join partywise_results p
on c.Party_ID = p.Party_ID
join statewise_results sr on c.Parliament_Constituency = sr.Parliament_Constituency
join states s on sr.State_ID = s.State_ID
where s.State = 'Andhra Pradesh'
group by p.Party order by seat_won desc

--What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024
select s.State as state_name, 
sum(case when p.Party_Alliance = 'NDA' then 1 else 0 end) as NDA_won,
sum(case when p.Party_Alliance = 'INDIA' then 1 else 0 end) as INDIA_won,
sum(case when p.Party_Alliance = 'Others' then 1 else 0 end) as Other_won
from states s join statewise_results sr
on s.State_ID = sr.State_ID
join constituencywise_results cr on sr.Parliament_Constituency = cr.Parliament_Constituency
join partywise_results p on cr.Party_ID = p.Party_ID 
group by s.State order by s.State

--Which candidate received the highest number of EVM votes in each constituency (Top 10)?
select top 10 cr.Constituency_Name, cr.Winning_Candidate, cd.EVM_Votes 
from constituencywise_results cr join constituencywise_details cd
on cr.Constituency_ID = cd.Constituency_ID
order by EVM_Votes desc 
 
--Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?
with RankedCandidate as (
select cd.Constituency_ID, cd.Candidate, cd.Party, cd.Total_Votes, ROW_NUMBER() over(
partition by cd.Constituency_ID order by cd.Total_Votes desc) as vote_rank
from constituencywise_details cd join constituencywise_results cr
on cd.Constituency_ID = cr.Constituency_ID
join statewise_results sr on cr.Parliament_Constituency = sr.Parliament_Constituency
join states s on sr.State_ID = s.State_ID
where s.State = 'Odisha')
select cr.Constituency_Name,
max(case when rc.vote_rank = 1 then rc.Candidate end) Winning_Candidate,
max(case when rc.vote_rank = 2 then rc.Candidate end) Runnerup_Candidate
from RankedCandidate rc join constituencywise_results cr
on rc.Constituency_ID = cr.Constituency_ID
group by cr.Constituency_Name order by cr.Constituency_Name

--For the state of Odisha, what are the total number of seats, total number of candidates,
--total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?
select count(distinct cr.Constituency_ID) as total_seats,
count(distinct cd.Candidate) as total_candidates,
 count(distinct p.Party) as total_parties,
 sum(cd.EVM_Votes + cd.Postal_Votes) as total_votes,
 sum(cd.EVM_Votes) as total_evm_votes,
sum(cd.Postal_Votes) as total_postal_votes
from constituencywise_details cd join constituencywise_results cr
on cr.Constituency_ID = cd.Constituency_ID
join partywise_results p on cr.Party_ID = p.Party_ID
join statewise_results sr on sr.Parliament_Constituency = cr.Parliament_Constituency
join states s on sr.State_ID = s.State_ID
where s.State = 'Odisha'