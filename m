Message-ID: <91b3572a0806081235t61b6b5f2g3e0d2a2200e9a702@mail.gmail.com>
Date: Sun, 8 Jun 2008 20:35:52 +0100
From: "Mathias HOUNGBO" <mathias.houngbo@gmail.com>
Subject: Re: [B.A.T.M.A.N.] question
In-Reply-To: <21DD4A18-C436-49CB-8B33-2729C10233AF@lo-res.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
References: <91b3572a0806080640n274dbb4qe9abe4082cbebb3c@mail.gmail.com>
	<21DD4A18-C436-49CB-8B33-2729C10233AF@lo-res.org>
Content-Transfer-Encoding: 8bit
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

Hi Aaron,

after put

iptables -F
iptables -t nat -F

in my firewall.user

It's impossible to access to the router :(

no ping, no ssh, no web interface



2008/6/8, Aaron Kaplan <aaron@lo-res.org>:
>
> On Jun 8, 2008, at 3:40 PM, Mathias HOUNGBO wrote:
>
>> Hi everybody;
>>
>> Someone can provide an howto on batman + openwrt kamikaze + adhoc +
>> firewall.user ?
>>
>
> firewall.user:
>
>
> just have the iptables fulshed. Like this:
>
> iptables -F
> iptables -t nat -F
>
>
>> thanks
>>
>>
>> --
>> Mathias HOUNGBO
>> http://mathias.houngbo.net/ (mon blog)
>> http://mathias.houngbo.net/wiki/ (mon wiki)
>> http://www.cotonou-wireless.org (le wifi enchainé)
>>
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>
> ---
> there's no place like 127.0.0.1
>
>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>


-- 
Mathias HOUNGBO
http://mathias.houngbo.net/ (mon blog)
http://mathias.houngbo.net/wiki/ (mon wiki)
http://www.cotonou-wireless.org (le wifi enchainé)

