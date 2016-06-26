Return-Path: <ruben@vfn-nrw.de>
From: Ruben Wisniewski <ruben@vfn-nrw.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Message-Id: <B82DBCAC-EC21-4486-B498-97FF1CC89BEC@vfn-nrw.de>
Date: Sun, 26 Jun 2016 10:54:18 +0200
References: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
 <1465557064-24406-3-git-send-email-apape@phoenixcontact.com>
 <1889511.W6T9spajgp@sven-edge>
In-Reply-To: <1889511.W6T9spajgp@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 2/6] batman-adv: speed up dat by
	snooping received ip traffic
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


Are new clients (Mac) not already spread as info on the network? So couldn't=
 we not just snoop dhcp traffic on gateways and spread the info about acknow=
ledged IPs as well?

> Am 25.06.2016 um 12:04 schrieb Sven Eckelmann <sven@narfation.org>:
>=20
>> On Friday 10 June 2016 13:11:00 Andreas Pape wrote:
>> Speeding up dat address lookup is achieved by snooping all incoming ip
>> traffic. This especially increases the propability in bla setups that
>> a gateway into a common backbone network already has a fitting dat entry
>> to answer incoming ARP requests directly coming from the backbone
>> network thus further reducing ARP traffic in the mesh.
>>=20
>> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
>> ---
>=20
> Marking this as rejected in patchwork due to the conceptual problems point=
ed=20
> out by Matthias + Linus [1].
>=20
> @Marek, I hope this helps to reduce the number of patches you have to go=20=

> through in patchwork. But please feel free to change it back when you thin=
k=20
> differently about it.
>=20
> Kind regards,
>    Sven
>=20
> [1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-June/015738.htm=
l

