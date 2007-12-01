Message-ID: <4751A22D.3060207@leipzig.freifunk.net>
Date: Sat, 01 Dec 2007 19:04:29 +0100
From: tetzlav <tetzlav@leipzig.freifunk.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] rv791 <---> rv824 incompatible?
References: <4750C29B.6030708@leipzig.freifunk.net>
	<200712011837.46218.lindner_marek@yahoo.de>
In-Reply-To: <200712011837.46218.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-15
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

Marek Lindner schrieb:
>>> [   7946500] Is an internet gateway (class 1)
>>> [   7946510] Drop packet: incompatible batman version (105)
>>>       
>
> In revision 812 the header format was changed due to future compability issues 
> (the version field is now the first field in the header).
> I'm sorry about the inconvenience -  it wont happen too often.

:-/ just this minute we included batmand-0.3 rv791 in our Leipziger
Freifunk-Firmware and now the newer Versions are incompatible with this
included version...
So wie never get an big connected batman-testbed in Leipzig in near
Future, because i think the the users wont update as often as
batmand-compat change.

The rv791 routes fine, but gateway make some Problems. So we included
this testet version and only request the users that _want_ to use
batman-gateway-tunnel tu update their batmand. (updatecheck is
includet)  -> now our Plans are broken... :-(

Why you dont enlarge the compat# from 4 to 5, or so?
Thats confusing, sorry...


Regards
tetzlav
