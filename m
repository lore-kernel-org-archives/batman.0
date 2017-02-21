Return-Path: <andrew@lunn.ch>
Date: Tue, 21 Feb 2017 18:00:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20170221170020.GF25818@lunn.ch>
References: <33547cb0-a540-e0b9-ffc7-99ac67c3d516@viisauksena.de>
 <20170221162435.GC25818@lunn.ch>
 <e7b68377-8a30-8f00-a247-163957f01ef4@viisauksena.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7b68377-8a30-8f00-a247-163957f01ef4@viisauksena.de>
Subject: Re: [B.A.T.M.A.N.] Interface limit 127 in bat0?!
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: jens <jens@viisauksena.de>
Cc: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Hi Jens

The script i just used is:

# add one if per 3 second and give output, also monitor dmesg
dmesg -w &
for i in `seq 1 255`; do
    # one interface
    ip link add gre$i type gretap local 192.168.99.1 remote 192.168.3.$i ttl 255 dev lan1
    ip link set up dev gre$i
    batctl if add gre$i
    # another inf
    ip link add grex$i type gretap local 192.168.99.1 remote 192.168.4.$i ttl 255 dev lan1
    ip link set up dev grex$i
    batctl if add grex$i
    echo -n $(uptime|cut -d"," -f4-) $(ifconfig lan1|grep TX\ p) $i
    sleep 3
done

So this adds two interfaces per 3 seconds to bat0.

root@wrt1900ac:~# batctl if
grex122: active
gre123: active
grex123: active
gre124: active
grex124: active
gre125: active
grex125: active
gre126: active
...
grex119: active
gre120: active
grex120: active
gre121: active
grex121: active
gre122: active


root@wrt1900ac:~# batctl if | wc
    344     688    5116

So i have 344 interfaces in the mesh. No memory problems reported.

   Andrew
