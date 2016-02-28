Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1456681344.1958.64.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Sun, 28 Feb 2016 18:42:24 +0100
In-Reply-To: <1456681096.1958.61.camel@gmail.com>
References: <1456616348.1958.16.camel@gmail.com>
 <10118093.UzH4NL7sLW@sven-edge> <1802876.jh3TWRFVis@sven-edge>
 <1456681096.1958.61.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batctl: page allocation failure
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

> this is interesting:
> 
> batctl o | wc -l
> 9320

more interesting:

# while true; do batctl o | wc -l; done
9474
9474
[…]

# while true; do batctl o | sort -u | wc -l; done
1764
1427
1705
1746
1568
1559
1558
1543
1429
1441
1506
1415
1429
1544
1605
1457
1497
1428
1447
1443
1423
1422
1495
1424
1427
…



