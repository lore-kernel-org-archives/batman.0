Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 03 Nov 2018 13:40:44 +0100
Message-ID: <1619865.vljUF8tqkC@sven-desktop>
In-Reply-To: <20181030111710.26217-1-sven@narfation.org>
References: <20181030111710.26217-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Use explicit tvlv
 padding for ELP packets
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

On Dienstag, 30. Oktober 2018 12:17:10 CET Sven Eckelmann wrote:
> The announcement messages of batman-adv COMPAT_VERSION 15 have the
> possibility to announce additional information via a dynamic TVLV part.
> This part is optional for the ELP packets and currently not parsed by the
> Linux implementation. Still out-of-tree versions are using it to transport
> things like neighbor hashes to optimize the rebroadcast behavior.
>=20
> Since the ELP broadcast packets are smaller than the minimal ethernet
> packet, it often has to be padded. This is often done (as specified in
> RFC894) with octets of zero and thus work perfectly fine with the TVLV
> part (making it a zero length and thus empty). But not all ethernet
> compatible hardware seems to follow this advice. To avoid ambiguous
> situations when parsing the TVLV header, just force the 4 bytes (TVLV
> length + padding) after the required ELP header to zero.
>=20
> Fixes: a4b88af77e28 ("batman-adv: ELP - adding basic infrastructure")
> Reported-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_v_elp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Added as 974337ee9773 [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/974337ee9773c4bd0a2d5c3=
22306cf2bea445e11



