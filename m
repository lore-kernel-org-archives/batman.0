MIME-Version: 1.0
In-Reply-To: <200903191055.53458.lindner_marek@yahoo.de>
References: <3ebdcf0a0903180743q3968e6a0wd480347cf70a50ff@mail.gmail.com>
	<200903191055.53458.lindner_marek@yahoo.de>
Date: Thu, 19 Mar 2009 14:38:14 +0100
Message-ID: <3ebdcf0a0903190638p583bababq7891e21413b4f4e@mail.gmail.com>
From: Max <rey.web.mail@gmail.com>
Content-Type: multipart/alternative; boundary=0015174bea24799fbe046578e99a
Subject: Re: [B.A.T.M.A.N.] Problem with B.A.T.M.A.N. 0.3.1 rv1206
	(compatibility version 5)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--0015174bea24799fbe046578e99a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thank you Marek and Marco for your suggestions.

I have solved the following problem:
>2) When launched in debug mode (using the command batmand -d 3 ath0 &), the
> daemon starts to generate OGMs and to fill up its routing tables in a
> correct way. The problem occurs when I tries to ping an host in the
network
> because the routing process uses the default routing table (that has not
> been modified by the batman daemon) and it is not aware on the correct
> batman routing tables.

Now I'm able to ping every originator in the network. The problem is derived
from some iptables filters that stop the ping. Executing the following
command I remove the filters solving the problem:

iptables --flush
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

As concern the other problem it's still present.
In my meshboxes, BATMAN sends OGMs only when it's launched in debug mode
using the command
"batmand -d 3 ath0 &". In this case, I see OGMs travelling in the network
using Wireshark and the command "ip route ls table 66" lists all reachable
batman nodes.

When I launch the daemon in normal mode, using the command "batmand ath0",
no error is displayed but no OGMs is observed to be travelling in the
network using Wireshark. The only message displayed is:
"Interface activated: ath0
Using interface ath0 with address 10.0.0.1 and broadcast address
10.255.255.255"

Also the command "ip route ls table 66" does not produce any output.

And finally another question...
Is it normal to observe 3 different processes named batmand using the shell
command ps?


Thank you in advance!

Best regards,
Massimo

--0015174bea24799fbe046578e99a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thank you Marek and Marco for your suggestions.<br><br>I have solved the fo=
llowing problem:<br>&gt;2) When launched in debug mode (using the command b=
atmand -d 3 ath0 &amp;), the<br>
&gt; daemon starts to generate OGMs and to fill up its routing tables in a<=
br>
&gt; correct way. The problem occurs when I tries to ping an host in the ne=
twork<br>
&gt; because the routing process uses the default routing table (that has n=
ot<br>
&gt; been modified by the batman daemon) and it is not aware on the correct=
<br>
&gt; batman routing tables.<br><br>Now I&#39;m able to ping every originato=
r in the network. The problem is derived from some iptables filters that st=
op the ping. Executing the following command I remove the filters solving t=
he problem:<br>
<br>iptables --flush<br>iptables -F<br>iptables -X<br>iptables -t nat -F<br=
>iptables -t nat -X<br>iptables -t mangle -F<br>iptables -t mangle -X<br>ip=
tables -P INPUT ACCEPT<br>iptables -P FORWARD ACCEPT<br>iptables -P OUTPUT =
ACCEPT<br>
<br>As concern the other problem it&#39;s still present.<br>In my meshboxes=
, BATMAN sends OGMs only when it&#39;s launched in debug mode using the com=
mand <br>&quot;batmand -d 3 ath0 &amp;&quot;. In this case, I see OGMs trav=
elling in the network using Wireshark and the command &quot;ip route ls tab=
le 66&quot; lists all reachable batman nodes.<br>
<br>When I launch the daemon in normal mode, using the command &quot;batman=
d ath0&quot;, no error is displayed but no OGMs is observed to be travellin=
g in the network using Wireshark. The only message displayed is:<br>&quot;I=
nterface activated: ath0<br>
Using interface ath0 with address 10.0.0.1 and broadcast address 10.255.255=
.255&quot;<br><br>Also the command &quot;ip route ls table 66&quot; does no=
t produce any output.<br><br>And finally another question...<br>Is it norma=
l to observe 3 different processes named batmand using the shell command ps=
?<br>
<br><br>Thank you in advance!<br><br>Best regards,<br>Massimo<br>

--0015174bea24799fbe046578e99a--
