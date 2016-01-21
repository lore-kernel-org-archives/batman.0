Return-Path: <a@unstable.cc>
References: <8047297.0qIFjkW2bL@voltaire> <4178376.2Vigxs1Xtt@bentobox>
 <56A0E335.8040207@openwrt.org> <1664897.xQoZSmslHn@bentobox>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <56A0E50A.5050209@unstable.cc>
Date: Thu, 21 Jan 2016 22:02:50 +0800
MIME-Version: 1.0
In-Reply-To: <1664897.xQoZSmslHn@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="At1bwu4w6iCJ7GLSvtSj6R8u2kI4C6d0e"
Subject: Re: [B.A.T.M.A.N.] OpenWrt cfg80211.h station_info incompatibility
 with kernel+mac80211 [was: B.A.T.M.A.N. V leaves the nest v2]
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Felix Fietkau <nbd@openwrt.org>
Cc: openwrt-devel@lists.openwrt.org, Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--At1bwu4w6iCJ7GLSvtSj6R8u2kI4C6d0e
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 21/01/16 22:03, Sven Eckelmann wrote:
> On Thursday 21 January 2016 14:55:01 Felix Fietkau wrote:
>>> @Felix, would it be ok for you when I propose a
>>> "*-sync-cfg80211-station_info.patch" for the 3.18 generic kernel patc=
hes?
>>> Or do you have a good idea how to force the openwrt-routing batman-ad=
v package
>>> against the cfg80211.h of compat-wireless?
>> The openwrt mac80211 package exports its headers to
>> $(STAGING_DIR)/usr/include/mac80211
>>
>> You could just make the batman-adv package use those includes.
>=20
> Thanks, missed that. I will prepare a pull request for openwrt-routing.=


In case this was missed: we also need to make sure that batman-adv
depends on mac80211 and that it gets compiled first.


Cheers,

--=20
Antonio Quartulli


--At1bwu4w6iCJ7GLSvtSj6R8u2kI4C6d0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWoOUPAAoJENpFlCjNi1MRxwQP/Ryox9lY4VHwpI2QF+fdj6/2
xhbpW+Ct5SasVdDKePSXMcqMeNG2K6DsTB27NqZb7A1mufkvnmel/LVaomPI0M47
4lgdMu3fK4khUDTcIZI0LTpmNaYG/TvWsEiWgetPlMMNhw6oQ8oc9rwF2M3KLanR
qRJSkMRYJ266QGFvvv8dXSvK5J1njrM8cNMpbd3LAzT1Fwjc6wiqTI04Dmp5bS21
7aiGu0oooDtar84kZOrXwLOxtHnNVDkQ+2t7+QmsKtmk8kgLLbOcPkwwG5OaZhmw
ipOyk+NeBapCCNl7R4YgybZsl7g+C3w/9b9x8jkDoAcGzwGGORuvqNXWcDgkk5w5
dX/aY/2v7RVjRExz1OoiylzLwYO55afxXvTh2NAQhbpcFnRCrTV/VYen42vvZ1NT
BHFrfd4L7K2LEJyE0SdEJhI0+GA0GWVGY8DtBeuDrZdG2gxWp+kdBau4i0R12b3y
G3B5rwgwFqSnFRBP3P3vBzA+y6r8MqyTihYibX5LB5xq7VkJOMFmy0seCoGr6lF/
8Nte260EgMk+wZd/PaIrMfxlyNaMNAtwVKS+ovzq+7yaQHakQ8S8fEUfC45dhlsB
5fwMJL1sB28ZgJcm5TAWRl0/TD8F6qP3LBITSymindiaTBzSq8wh8rwGOx9mnHqX
ygqvIu/x0xIVEJtgEEAS
=n8NJ
-----END PGP SIGNATURE-----

--At1bwu4w6iCJ7GLSvtSj6R8u2kI4C6d0e--
