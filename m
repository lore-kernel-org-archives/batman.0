Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <518EE295.4020501@altermundi.net>
Date: Sun, 12 May 2013 02:30:13 +0200
From: =?windows-1252?Q?NicoEch=E1niz?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <CAHQ_bgg6rTMN2wnnToQLTwXx+U_U3scbOY3zmz6m-_wX7xzoHw@mail.gmail.com>
In-Reply-To: <CAHQ_bgg6rTMN2wnnToQLTwXx+U_U3scbOY3zmz6m-_wX7xzoHw@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Performance Comparison (Batman-adv. vs. 802.11s)
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 05/11/2013 03:29 PM, ajeet singh wrote:
> Hello All,
>=20
> Thanks a lot for reply.
>=20
> After applying patch
> http://www.spinics.net/lists/linux-wireless/msg107080.html , I am able
> to run batman-adv and 802.11s on top of the same wireless chipset (One
> after another).
>=20
> I am using Atheros-AR9271 chipsets (ath9k_htc) for my tests.
>=20
> I am getting good ping latency in both cases IBSS (Batman-adv) and
> mesh mode (802.11s), but latency fluctuation is there in the case of
> mesh mode.
>=20
> 802.11s gives around 15 mbps between two nodes but there is unexpected
> throughput result in the case of batman-adv. It=92s coming in kbps
> sometimes.
>=20
> As I have tested batman-adv with different chipsets and got pretty
> good throughput around 30 mbps. I suspect there may be something with
> ath9k_htc driver and batman-adv compatibility. I will be investigating
> the problem in details. Please let me know if you people have any
> information related to this problem.

ath9k_htc has problems with adhoc mode, while in infrastructure it works
fine. I'd recommend you use some ath9k hardware if you have the chance.

cheers,
NicoEch=E1niz
