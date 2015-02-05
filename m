Return-Path: <moritzwarning@web.de>
Message-ID: <54D3B243.9060800@web.de>
Date: Thu, 05 Feb 2015 19:11:15 +0100
From: Moritz Warning <moritzwarning@web.de>
MIME-Version: 1.0
References: <54CE26E4.7070307@web.de> <1941941.HLll8057rP@prime>
In-Reply-To: <1941941.HLll8057rP@prime>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iEOQ0Q2776DxJ9WBsHA7daTuF6KtrSNQ2"
Subject: Re: [B.A.T.M.A.N.] batctl: feature to filter nodes/clients
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
To: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iEOQ0Q2776DxJ9WBsHA7daTuF6KtrSNQ2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the response!

On 02/05/2015 01:34 PM, Simon Wunderlich wrote:
> Hi,
>=20
> On Sunday 01 February 2015 14:15:16 Moritz Warning wrote:
>> Hi,
>>
>> I need to display the number of all nodes/clients as well as all neigh=
bor
>> nodes/clients. This would be easy if batctl would be able to output th=
e
>> respective list of mac addresses (batctl ... | wc -l).
>>
>> I've started writing a patch as part of a feature request:
>> http://www.open-mesh.org/issues/203
>>
>> But the problem is how to get the respective output form the debug tab=
les.
>> I have been reading the docs, but have not been able
>> to understand the necessary information needed, no offense:
>>
>> http://www.open-mesh.org/projects/batman-adv/wiki/Understand-your-batm=
an-adv
>> -network
>>
>> Some explanation beforehand:
>> Clients are computers not running batman-adv,
>> represented by the MAC address of its network interface.
>> Nodes are computers running batman-adv,
>> represented by the MAC address of its primary interface.
>>
>> List of all nodes:
>> Get all MACs from the 'Originator' column of the originator table
>=20
> Note that this may also show secondary interfaces of your neighbors - y=
ou may=20
> have to filter that against a list of primary interfaces you collect ot=
herwise.
Ok, I wonder how I can filter out those secondary interface MAC addresses=

of 1-hop neighbors.
Can those addresses be recognized by comparing it to the Nexthop column?
This seems to be the major problem for me right now.

>=20
>>
>> List of all neighbor nodes:
>> Get all MACs from the 'Nexthop' column of the originator table
>> and make it a unique list.
>=20
> That sounds about right, if you want to include all neighbors which are=
 in=20
> radio range (even if you are not currently sending to them). Alfred-vis=
 for=20
> example only considers neighbors which are actually chosen for some=20
> connections. Again, you may include secondary interfaces.
>>
>> List of all clients:
>> Get all MACs of the 'Client' column of the transtable_local table
>> when it starts with a '*' character.
>=20
> Yes, but you may want to filter out local mac addresses, which are conf=
igured on=20
> top of VLANs on bridges.
Are those the MAC-addresses of the bridge interface. Say, when I bridge b=
at0 into
br-lan, then the MAC of br-lan will show up as client?

>>
>> List of all neighbor clients:
>> Get all MACs of the 'Client' column of the transtable_global table
>> when it starts with a '*' character and when the nodes own originator
>> MAC (of the primary interface?) is also in the 'Originator' column.
>=20
> Yup, but in this case again you don't know what are clients and what ar=
e=20
> bridges/vlans configured on top of your other nodes. That's going to be=
 tricky=20
> to filter.
>=20
> How about you use alfred-vis or your own alfred-based service to do the=
=20
> filtering properly? Some kind of distributed/centralized database would=
 help on=20
> the filtering job, IMHO.
>=20
> Cheers,
>     Simon
>=20



--iEOQ0Q2776DxJ9WBsHA7daTuF6KtrSNQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCAAGBQJU07JHAAoJECHrh56PP4wpEDgIALbxDttoCFFvBWWkgl3QEhQH
+sUng0I+Cr8vWXEXZY3q1d4qmhp3SOyzE3yem1RHM3aJFD8o2moIoZeqAhtwrygY
p1SyknHaNiKAfvgBKhhppdDcw3pbI30h4Y90hF3tfMwR+Oyh/jbI5W9SpfnDTrTE
xN8FlW9ivdLNoTF+knyIODjnoWufxa+hadJ/bRxcga7GqdqMRdjWxy8CjGskS5eR
RhlydBzv/KT1q5ZdBVBZEbz2nRXvFbf+bI/E7qq9hZdQ/BZQ1PSYmazlWeV9UWmn
J2C1QN2M9e4imUIBK+RO/FKnDuMX//gwU6LsXqMaxBqsk4GTUX5nL3jaRXEljv8=
=WzfJ
-----END PGP SIGNATURE-----

--iEOQ0Q2776DxJ9WBsHA7daTuF6KtrSNQ2--
