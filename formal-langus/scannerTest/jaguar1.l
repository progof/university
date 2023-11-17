%{
/* jaguar1.l
   Rozpoznawanie znaczenia slowa jaguar
   w zaleznosci od kontekstu z wykorzystaniem flagi */
char flag; %}
%%
^a flag = 'a';
^b flag = 'b';
jaguar                  switch(flag) {
                          case 'a':  printf("Duzy kot\n"); break;
                          case 'b':  printf("Samochod sportowy\n"); break;
                        }
.|\n ;


Zadanie polega na stworzeniu skanera do analizy logów sniffera tcpdump.
Skaner po wczytaniu prawidłowego logu ma wypisywać informację o godzinie i adresie IP hostów, które były pingowowane (pakiety icmp) z serwera 149.156.55.130.
Przykładowo dla wejścia:

11:57:11.625157 IP 149.156.55.130 > 149.156.96.21: icmp 40: echo request seq 11008
11:57:11.625810 IP 149.156.96.21 > 149.156.55.130: icmp 40: echo reply seq 11008
11:57:12.617153 IP 149.156.55.130 > 149.156.96.21: icmp 40: echo request seq 11264
11:57:12.617722 IP 149.156.96.21 > 149.156.55.130: icmp 40: echo reply seq 11264
11:57:13.617003 IP 149.156.55.130 > 149.156.96.21: icmp 40: echo request seq 11520
11:57:13.617576 IP 149.156.96.21 > 149.156.55.130: icmp 40: echo reply seq 11520
11:57:13.923781 IP 149.156.55.130.1791 > 66.102.9.99.80: P 1560712269:1560712573(304) ack 2114831406 wi
11:57:13.980726 IP 66.102.9.99.80 > 149.156.55.130.1791: . ack 304 win 7886
11:57:13.981908 IP 66.102.9.99.80 > 149.156.55.130.1791: . ack 304 win 6432

na wyjściu może się pojawić:

Hosty pingowane z serwera 149.156.55.130:
11:57:11 host 149.156.96.21
11:57:12 host 149.156.96.21
11:57:13 host 149.156.96.21

Proszę sprawdzać poprawność tej części linii, która znajduje się przed : (tj. 11:57:11.625157 IP 149.156.55.130 > 149.156.96.21:), w tym poprawność godziny i adresu IP.

