Return-Path: <a@unstable.cc>
Date: Mon, 19 Dec 2016 18:10:24 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20161219101024.GB8485@prodigo.lan>
References: <CAPkwMUejbf31RfVY_nCJSVwe=_mGVO3y5PY9zzfkQk0eDc1HTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPkwMUejbf31RfVY_nCJSVwe=_mGVO3y5PY9zzfkQk0eDc1HTA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Fail to create tunnels using br-lan
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
Cc: Francisco Javier =?iso-8859-1?Q?Sim=F3?= Reigadas <javier.simo@urjc.es>, Andrei Buciulea <andreibuciulea@gmail.com>

On Mon, Dec 19, 2016 at 11:06:01AM +0100, Carlos Rey-Moreno wrote:
> Hi everyone,
> 
> A student who is collaborating with me, Andrei, cc'ed, is carrying out
> traffic performance analysis in a mesh network (which uses batman-adv)
> in order to compare the benefits of introducing Simplemux [1].
> Basically, simplemux multiplexes small packets in bigger packets and
> compresses them to reduce overhead. These packets are then sent
> through a tunnel to another end in the network.
> 
> So far, simplemux shows very positive results by creating the tunnel
> in between two computers connected at each end of a multihop network
> composed by a chain of 5 nodes.
> 
> The idea would be to test the performance benefits of simplemux when
> the tunnels are created between the mesh nodes instead, so they could
> aggregate, let's say, all the VoIP packets from different SIP clients
> calling other SIP clients in the mesh or via the gateway.
> 
> The tunnels can be successfully created in OpenWRT, but it fails when
> assigning the physical interface the tunnel should use. It works when
> a physical interface is used, i.e. eth0, but fails with br-lan
> provided it is a virtual interface.
> 
> # openvpn --mktun --dev tun0 --user root
> 
> # ifconfig tun0 up
> 
> # ./simplemux -i tun0 -e br-lan -M N -c 192.168.0.5
> 
> I was wondering if anyone in the list could point Andrei in the right direction.
> 
> Thank you very much in advance.

Dear Carlos,

this looks pretty much about OpenVPN (if I am not wrong). Are you sure you
posted it to the right mailing list?

Cheers,

-- 
Antonio Quartulli
