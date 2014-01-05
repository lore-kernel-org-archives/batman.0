Return-Path: <antonio@meshcoding.com>
Message-ID: <52C9B659.8040400@meshcoding.com>
Date: Sun, 05 Jan 2014 20:45:29 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1388912394-824-1-git-send-email-antonio@meshcoding.com>
 <2648905.iCJy0vMviH@diderot>
In-Reply-To: <2648905.iCJy0vMviH@diderot>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7ejepQK6B7UtJ5ASTkTGlK9BUMjWJF1cH"
Subject: Re: [B.A.T.M.A.N.] [PATCH next 1/3] batctl: introduce rtnl_open()
 helper function
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ejepQK6B7UtJ5ASTkTGlK9BUMjWJF1cH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/01/14 15:04, Marek Lindner wrote:
> On Sunday 05 January 2014 09:59:52 Antonio Quartulli wrote:
>> @@ -528,7 +526,7 @@ static int resolve_mac_from_cache_open(int ai_fami=
ly)
>>         if (ret < 0)
>>                 goto outclose;
>> =20
>> -       ret =3D send(socknl, &nlreq, nlreq.hdr.nlmsg_len, 0);
>> +       ret =3D send(socknl, req, len, 0);
>>         if (ret < 0)
>>                 goto outclose;
>>  out:
>> @@ -538,6 +536,22 @@ outclose:
>>         return ret;
>>  }
>> =20
>> +static int resolve_mac_from_cache_open(int ai_family)
>> +{
>> +       struct {
>> +               struct nlmsghdr hdr;
>> +               struct ndmsg msg;
>> +       } nlreq;
>> +
>> +       memset(&nlreq, 0, sizeof(nlreq));
>> +       nlreq.hdr.nlmsg_len =3D NLMSG_LENGTH(sizeof(nlreq.msg));
>> +       nlreq.hdr.nlmsg_type =3D RTM_GETNEIGH;
>> +       nlreq.hdr.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_DUMP;
>> +       nlreq.msg.ndm_family =3D ai_family;
>> +
>> +       return rtnl_open(&nlreq, sizeof(nlreq), NETLINK_ROUTE);
>> +}
>=20
> Is 'sizeof(nlreq)' equal to 'nlreq.hdr.nlmsg_len' ? It seems not ...

It is because the macro NLMSG_LENGTH adds NLMSG_HDRLEN to the value
passed as argument (in this case it is sizeof(nlreq.msg)) and therefore
what we store in nlreq.hdr.nlmsg_len is sizeof(nlreq) (plus some
possible alignment bytes).

I think I can make it more clear and always pass nlreq.hdr.nlmsg_len to
send().


Thanks!

v2 is coming!


Cheers,


--=20
Antonio Quartulli


--7ejepQK6B7UtJ5ASTkTGlK9BUMjWJF1cH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSybZoAAoJEEKTMo6mOh1V7u8QAIkUjFfUvYr6WB8CNhVb/Vtq
GO/+O2xUmeMW+ewVcqXx+DjjNjqPl8BZaEJexrtVMrZdhJjRPhmrpF6kA3yM6tVl
nXiXdZmYdcMhTAyZ4gHHEJXz+WQW2nf/KM6eSq+qTsz/Av7PagWmeRRiBW12SgTe
4fgee+xCj27E70c6IKMQT6XELBP504/tIAf1hMoe9H/a1q8aWwYqYPZ/czyglQhP
BzlRXWwCoufkyQVu/kcOzxwqHQReUzXpMAS3Kv92fZ51HjYJyWio1bwPYDBFoaOZ
f8dDDiJoB2akQn6QMMONiprCGeyBufmVG6bCIAqGWHJFG31HVUdwUfqVMGeSRUin
OqQwG5zSoIp+6R6eSTh2gwcfTLz31jpr4jNn7AvQbg/mgaHeLb+yf/ad0AKxjwd0
n5FcGwmOkiVN8j0sTvFhEeEVX02zqTzMro6yZPEvEq6iKrBtIfJLFva1K7LHtfXL
/+Uff2Wal/DPUVbGJTkmb1dPW734aUSLVnJIRHK9JQmDMN50Az4hmQsJCWn/7qT6
DDZavZ6wX3+hiAJFaVE1JVufevUtCBO1Z30zN/hou0XlT8UayaZhtyW48FjnvM03
fxTs1laIAQ7CqkMukvvMsqLjwdf/EBNs6YiAf/x7xvSy5MsddbeZ9gqFaZdupmec
9Z4hzPaSaXn2HL6EFbH2
=GYBP
-----END PGP SIGNATURE-----

--7ejepQK6B7UtJ5ASTkTGlK9BUMjWJF1cH--
