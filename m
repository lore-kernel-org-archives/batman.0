Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Nov 2013 15:52:11 +0800
Message-ID: <1707741.pOqQd3Qijv@diderot>
In-Reply-To: <1383595181-2061-1-git-send-email-antonio@meshcoding.com>
References: <1383595181-2061-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1561904.WUcPJk9oH3";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: deselect current GW on
	client mode switch off
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
To: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@open-mesh.com>


--nextPart1561904.WUcPJk9oH3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 04 November 2013 20:59:40 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> When switching from gw_mode client to either off or server
> the current selected gateway has to be deselected.
> In this way when client mode is enabled again a gateway
> re-election is forced and a GW_ADD event is consequently
> sent.
> 
> The current behaviour instead is to keep the current gateway
> leading to no GW_ADD event when gw_mode client is selected
> for a second time
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
> 
> Patch 2/2:
> - rename gw_deselect to gw_reselect in gw_client.h
> 
> Cheers,
> 
> 
>  gateway_client.c | 4 ++++
>  sysfs.c          | 9 +++++++++
>  2 files changed, 13 insertions(+)

Applied in revision 99a6eb5.

Thanks,
Marek

--nextPart1561904.WUcPJk9oH3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSeKOrAAoJEFNVTo/uthzAymEIAJB4yf4FftJUIB2H00c8Zk/d
kGR61q3G55Tv+M5GIHvQ+YHVXckd8gEMquut9f43/DbjhBip9DghgGQFEK8NulTe
fqNU6y/8ynu3CIaSkZRLXQhd4lzx8P2dQaRUNgnU/tBNBsVQ6kFvROGq+WtFJbxo
QVPgbhCnVzm0pnFja70pRh4ZczUsqdmwcPXoNNrBe4YCBzfyHTlzt27/uVhjMt/B
xikE8Iv40AaCf+VDzKGHzcnbog5NTGFn/0MminfNmFfGxfqhHH6adGpQAsxiRCuO
XRkMtEDKRW1UwUQ2MBpPGmcFSPQAezZnI8KwdrdP6KA7huPCeP37uogxOD3Mlj8=
=mJp4
-----END PGP SIGNATURE-----

--nextPart1561904.WUcPJk9oH3--

