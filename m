Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 27 May 2016 13:57:31 +0200
Message-ID: <1623525.LPZfOt2ObD@prime>
In-Reply-To: <mailman.211.1463472563.23655.b.a.t.m.a.n@lists.open-mesh.org>
References: <mailman.211.1463472563.23655.b.a.t.m.a.n@lists.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5405381.SVtJIasZ0V";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] How to read batadv-vis jsondoc correctly
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Patrick Bosch <patrick.d.bosch@googlemail.com>

--nextPart5405381.SVtJIasZ0V
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Hi Patrick,

sorry for the late reply.

On Tuesday 17 May 2016 10:09:27 Patrick Bosch via B.A.T.M.A.N wrote:
> Hi all
> 
> As the title suggest, I'm wondering how to read the jsondoc output
> correctly. It seems that every possible link is included in that
> output, but which one is the one that is used? If there is one link,
> it should be the one with the lowest metric, but what if a node has
> more than one link?
> 
> For example the following setup:
> 
> Node 1
>      |
>      |
> Node 2 ------- Node 3
> 
> Here, node two would have two links. Now, if there would be some more
> nodes that are in the jsondoc output, how can I find out which are the
> links that are in use?

The nodes which appear in the jsondoc are only originators which batman-adv 
decided to reach directly (with one hop) - so these are direct neighbors. 

Basically, all of these links would be in use from one node to its neighbor, 
so all of them are "in use". But you can't find out how much a link is 
actually used (i.e. how many packets/bytes are transmitted), or which neighbor 
is used to reach a distant neighbor.

Cheers,
     Simon
--nextPart5405381.SVtJIasZ0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXSDYrAAoJEKEr45hCkp6hWOEQAMRtDxb4QR/PTBFjhlc/LqpI
jLhinaWWkVzcw6/MAis3O+FvEcRCF/KJiMbktYBwPBg82IHyXDgnVQRRx6lRdrGJ
m/bYbDZ4TfYCXgXfgXbJ18TKrjnK4zWMDu4PrMHUW/VvHdQqnPz2tswH2ItY74W+
oPUZerFSk0Ky5tpGDPu1T5Znfz+MQd7q3oJhM/nbA0BXE3PcNYOBAonJHeUJ1B4O
k688dtk+/LHBoiQUHe+l2MqG/+XshsUPCY5maj1FwA/bsGRU+d7P/LyJfg9IzJ3O
vG53jyLCTtOFp4V7PqW32Is8n1aSpmLhaCWbt5BiZynJVzRVzyM104nQWqHZCL29
pZEcHOcLP6xauUho1lWD8LHIdESqtqg+VN2dQfvMQljAb+BSGuMQ3qCGl33zIfeI
vPHok9p4mLLiKU0Up7/5390znKypRNg0gWSFFz6L5/045rbz/8Vksj9SVGM3FNVb
CxraLi4N5vN/dLjJ9f2RPVvI9JqwmcYvagf3ttKheF1fK1jqb8lQ3AHC5j7xCb6U
HYbIR+HostciXk4KU3Yy2uSVVseTDt0e9z+etklTivUmD576sebrRy3GJ9dpgdVQ
BYg3n7c9LXvYjNlXQKhj+5yxxOeGdGVo1EuKFAthYHekjDlxTqgsJ2zrH7uC/eon
UVwtaqUVbtyio/Fq0x9I
=9eQq
-----END PGP SIGNATURE-----

--nextPart5405381.SVtJIasZ0V--

