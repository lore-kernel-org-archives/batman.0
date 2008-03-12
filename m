Message-ID: <47D82E1B.1040802@gmx.net>
Date: Wed, 12 Mar 2008 20:25:15 +0100
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Gateway routing / finding
References: <49584.70.128.180.22.1205342204.squirrel@webmail.reglue.org>	<47D8148D.600@gmx.net>
	<35440.70.128.180.22.1205347786.squirrel@webmail.reglue.org>
In-Reply-To: <35440.70.128.180.22.1205347786.squirrel@webmail.reglue.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi -
> Sorry, I wasn't sure what constituted 'newer.'  
<quote>

Btw.: IANA has assigned port 4305 for the newer versions of Batman. _So 
if you are going to update to_ Experimental or Beta open the firewall 
for udp ports 4305 and 4306 instead of 1966. 4305 is for protocol 
messages, 4306 is used for tunneling traffic to the gateway.  If you 
want to use the VIS server, open port 4307 also.

</quote>

Which interfaces did you (or the system that you have installed) assign 
to br-lan? You shouldn't assign a interface to batman twice (by itself 
and as part of a bridge)



