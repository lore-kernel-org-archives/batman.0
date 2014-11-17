Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 17 Nov 2014 19:07:30 +0800
Message-ID: <2137664.mQR8JuzZmq@diderot>
In-Reply-To: <1411230125-21848-1-git-send-email-antonio@meshcoding.com>
References: <1411230125-21848-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1860141.sbOsBRTG4N";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: avoid NULL
	dereferences and fix if check
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart1860141.sbOsBRTG4N
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 20 September 2014 18:22:05 Antonio Quartulli wrote:
> Gateway having bandwidth_down equal to zero are not accepted
> at all and so never added to the Gateway list.
> For this reason checking the bandwidth_down member in
> batadv_gw_out_of_range() is useless.
> 
> This is probably a copy/paste error and this check was supposed
> to be "!gw_node" only. Moreover, the way the check is written
> now may also lead to a NULL dereference.
> 
> Fix this by rewriting the if-condition properly.
> 
> Introduced by 0853ec7fafe0a195754454832993c6b35e22b842
> ("batman-adv: tvlv - gateway download/upload bandwidth container")
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> Reported-by: David Binderman <dcb314@hotmail.com>
> ---
> 
> This patch makes "batman-adv: avoid NULL dereferences and clarify if check"
> obsolete.
> 
> 
>  gateway_client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision cb2b79e.

Thanks,
Marek

--nextPart1860141.sbOsBRTG4N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUadb1AAoJEFNVTo/uthzAbucH/i9AT/1MfAy7YWmNRRcqKd/H
6CkkOIMOjLvHnDcu7TIHPj888BI3aoikC3MprkkPoiokApCu6GmstOTUFTNugxym
srNtSScPFod4ZF6um8FhqwbgCjllQzSjBDOHJ2onPq8uDyG/WKhOJyBNb2mbvIp3
4jW1p2R6x/nIOk1LcBCLBoBgiBjTmxmVs1EXy0KR3n/UqSLqxT6ISyYrnIgOoz8I
jP+TsaWtbQUrN071mRuuQzogaXRuqi0HsVmFs2Pb74I5/uEIpfxOI1Qz06Bt75AL
HpDnn/o1lKFmmFcUNrRwczBLAcCz0SZt4WOMwiMQuI9kvux7q83h5sADboRwxs4=
=x+v6
-----END PGP SIGNATURE-----

--nextPart1860141.sbOsBRTG4N--

