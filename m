Return-Path: <martin@hundeboll.net>
Message-ID: <51A59E1F.5070204@hundeboll.net>
Date: Wed, 29 May 2013 08:20:15 +0200
From: =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1369779649-2537-1-git-send-email-ordex@autistici.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [RFC 00/10] Improving the routing protocol
	abstraction
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <ordex@autistici.org>

Hi Antonio,

Great work. We are looking forward to the next generation of Batman=20
(shouldn't that be Robin?) :)

On 2013-05-29 00:20, Antonio Quartulli wrote:
> Antonio Quartulli (10):
>    batman-adv: make struct batadv_neigh_node algorithm agnostic
>    batman-adv: make struct batadv_orig_node algorithm agnostic
>    batman-adv: add bat_orig_print function API
>    batman-adv: add bat_metric_get API function
>    batman-adv: add bat_metric_is_similar API function
>    batman-adv: add bat_metric_compare API function
>    batman-adv: adapt bonding to use the new API functions
>    batman-adv: adapt the gateway feature to use the new API functions
>    batman-adv: adapt the neighbor purging routine to use the new API
>      functions
>    batman-adv: provide orig_node routing API

I see that in nc.c you changed the uses of neigh_node->tq_avg to the new=20
private algo-specific struct (neigh_node->bat_iv.tq_avg), but there is=20
no patch to make nc.c use the new API (bat_algo_ops.bat_metric_get() )...

Is this because you were in doubt wether NC will be usable with bat_v or=20
just because you did "make && git-push" ? :)

I am sure NC will need some work in order to support bat_v, and I will=20
try to catch up soon...

--=20
Kind Regards
Martin Hundeb=F8ll
Frederiks All=E9 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net
