Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 24 Feb 2017 18:56:58 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170224175658.GF4202@otheros>
References: <CAM0tZWaO3F5D1KzPX85V4ydGSj_a0cXc29xhchUwTxVcnexVdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM0tZWaO3F5D1KzPX85V4ydGSj_a0cXc29xhchUwTxVcnexVdA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Node freezes but still alive
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Fri, Feb 24, 2017 at 10:48:35AM -0600, Derick Roman De Leon Leal wrote:
> Thanks for the quick reply Linus,
> 
> No transmission on IPv4

If that's for the adhoc0 interface directly then this seems to be
a wireless driver issue and not a batman-adv one :(.

Hm, if I'm not mistaken then the OM2P-HS should have an Atheros AR9285
chipset. So an ath9k driver which many people use in adhoc mode
for meshing. 

> Someone suggested that I should use a bssid that
> starts with 02 (eg. 02:12:34:56:78:9A). Is this a requirement for the
> mesh to work?

Not a "requirement for the mesh to work", afaik. But when a MAC
address is self-generated, then it should have the second lowest bit set:

https://en.wikipedia.org/wiki/MAC_address#Address_details


Not sure, maybe you just hit a bad OpenWRT revision? Maybe give
the new LEDE release [*] or a newer OpenWRT version a try?

Regards, Linus

[*]: https://lede-project.org/releases/17.01/start
