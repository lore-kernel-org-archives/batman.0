Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 15:57:03 +0200
Message-ID: <2219629.dYY2ZvZvNG@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5202210.uFRsHKNLak";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH v3 0/8] batman-adv: Support for complex
	compat patches
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

--nextPart5202210.uFRsHKNLak
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

here is the updated patchset to get complex compat patches support in batman-
adv. The initial three patches of the last patchset [1] are already part of 
batman-adv.git next. This part is mostly about getting coccinelle/spatch to 
work.

Changes in v3:

 - rebased to get it working on top of current master
 - use __genl_const for batadv_netlink_ops to keep it in ro memory for
   kernel >= 3.13

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-October/016375.html

--nextPart5202210.uFRsHKNLak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBiovAAoJEF2HCgfBJntGXv0P/iB6QA/Z9z2HEhLsHC9ZzhfE
dZh6bZyNkJgCxdxYfeVcnv9YOSd5LqqdV9m84vRvtUaaAnyJwvDmSdwo2tY3s8Cg
t+eUhk6NyMsMbN0hQgz9m2/kypQOuB0QXEaz2LoI1QIU23Z8SB6AkAMvYu0M+o5T
5WfPxq0ThQqcbzKJg7XrE1iR3nI7v3dbdgSqsAKdJKvrAzPEUmNn7VHdUFmPdulR
LWYVai+502yuE8EuaGBJaw/DCrjIBKNCI3RSt7AyrNcsyEPVOic51UwzWMfqUPxP
9R5lslAUej2kW15V+c39ykqkYLvIwYV6BAGCnenThB1d1C09+P1UgkbDkNyYvXL3
inR0k/iPFW3hz6LP2UsBYqlvYlZn6AOwKwHJ0wxZnFvD1DD96CILgZf9OlRaqJWT
Zl1CXKjSbD6ZRufbSgZ2VTpu8iPKD/lEHGqPtifW5L2JB/aU1/GFARi76v7zCf64
gh41p+A9EuXH1JKo5IvPQ/ahCfdNDH03bJArdFHSo1WCFFwMaCDCYGapPPeuedSF
XnE3j7HxXHyUibHL/ZqkxegpjJa3lTr/wfqN2QOLAcp5NNHKx+e5GqoSom165NIC
qfiNLm3t+IadkNhWc902sRJNQfZ+KUVeWwAJkNDAjoD6vp375P7wYFMNolCb6YXw
54HmiP+YTVTxai+inbDv
=5D52
-----END PGP SIGNATURE-----

--nextPart5202210.uFRsHKNLak--

