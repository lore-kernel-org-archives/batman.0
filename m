Return-Path: <booray@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAxzKbSs+HGDsR1jacP1GWWzFDSHyDiCVJNBv=sabeRbupa0gw@mail.gmail.com>
References: <CAAxzKbSv9+vcOVCcoqg9FDOskuZd=_GK2pmq7jk4E4eAQbqWYg@mail.gmail.com>
 <CAA51LVoFGGgaefVXr01YXxJf+VnBFBGjjxr1ftKjkFkP9UMHHw@mail.gmail.com>
 <CAAxzKbSs+HGDsR1jacP1GWWzFDSHyDiCVJNBv=sabeRbupa0gw@mail.gmail.com>
Date: Tue, 2 Dec 2014 15:49:11 -0800
Message-ID: <CAA51LVpZmv8UmH5WY-oC1C-+9DkXVpq1ZYMHTDvAun4ft-JxNQ@mail.gmail.com>
From: Ray Gibson <booray@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Bridging multiple mesh segments across WAN
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

Travis,

Here are my configurations.  This was done on two dual interface
ubuntu computers acting as routers, with eth0 being plugged into the
local lan and eth1 being the "wan" connection".  lan0 is a bridge of
eth0 and bat0 on each, and bat0 contains tap0 (and tap1.. tap2... etc
for ring/star topologies)

Site "A" interfaces file:
# vpn server interface
auto tap0
iface tap0 inet static
  address 0.0.0.0
  pre-up /usr/sbin/tunctl -u root -t tap0
  pre-up /sbin/ifconfig tap0 mtu 1500
  post-down /usr/sbin/tunctl -d tap0

# local network
auto lan0
iface lan0 inet static
  address 192.168.100.1
  netmask 255.255.255.0
  bridge_ports bat0 eth0
  pre-up /sbin/ifconfig eth0 mtu 1468
  pre-up /sbin/modprobe batman-adv
  pre-up /usr/local/sbin/batctl if add tap0
  pre-up /sbin/ifconfig/bat0 mtu 1468
  post-down /usr/local/sbin/batctl if del tap0
  post-down /sbin/rmmod batman-adv

The only difference about Site "B"'s interfaces file would be a
different address line (192.168.100.2)

Site "A" openvpn conf:
mode server
local 10.10.10.1    # (this would be your wan interface IP that it's
listening on)
port 1194
dev tap0
proto udp
server-bridge
ca ca.crt
cert server.crt
key server.key
dh dh1024.pem
keepalive 10 60
persist-tun
persist-key
status /var/log/openvpn1194.status
log-append /var/log/openvpn1194.log
verb 3

On the client, Site "B", replace the first three lines of the above file with:
client
daemon
remote 10.10.10.1 1194

Of course, set appropriate encryption values for openvpn if you need
extra security.  I was doing the above in a lab setup with virtual
machines, and at one point succeeded in doing it over a wan link, but
those VM's are long gone, this is the closest thing I have.  Same idea
though.  The key part is that openvpn is set up in a server-bridge
configuration without ever setting any IP addresses on the tap
interfaces.  When everything is up successfully, you should be able to
ping back and forth between 192.168.100.1 and 192.168.100.2 and
because of the lan0 bridge, anything in the same subnet on either side
of the equation.

Good luck.

Ray


On Tue, Dec 2, 2014 at 2:37 PM, tjhowse <tjhowse@gmail.com> wrote:
> Hi Ray,
>
> That sounds like it would save me a lot of legwork. If you could post
> something up that would be brilliant. Feel free to email me directly
> if the list doesn't accept attachments.
>
> Thanks,
> Travis.
>
> On 27 November 2014 at 09:21, Ray Gibson <booray@gmail.com> wrote:
>> On Wed, Nov 26, 2014 at 3:05 PM, tjhowse <tjhowse@gmail.com> wrote:
>>
>>> I would like to join up the separate mesh segments, via the site
>>> network, such that a client to one segment can ping a client of
>>> another network, having the traffic transparently tunnel via the WAN.
>>> Has anyone looked at doing this in the past?
>>
>> I've successfully added tap interfaces into bat0, with openvpn
>> connecting the sites in a ring, with no problems.  It took a little
>> while to get the MTU's right as each layer has its own overhead, but
>> it worked great and clients in one state acted as if they were on the
>> same switched network as clients in the other.
>>
>> I can dig up some example configs if it's useful to you or the group.
>>
>> Thanks,
>>
>> Ray
