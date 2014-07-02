Return-Path: <locborgtus@gmail.com>
MIME-Version: 1.0
In-Reply-To: <53B29AFF.2070405@meshcoding.com>
References: <CAHxBzxWTprWsPASmNNGXQqj58LRuAHUkNVtXcWHc1PdoD_4+KA@mail.gmail.com>
 <20140701085027.GA2341@Linus-Debian>
 <53B29AFF.2070405@meshcoding.com>
Date: Tue, 1 Jul 2014 18:24:02 -0700
Message-ID: <CAHxBzxW7PCytsQKk-RyuaXVkAz4oqEJGvJE-HFBh=sn56UQP-g@mail.gmail.com>
From: Simon Wong <locborgtus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Roaming issues in basic network
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

A few more observations:

- Client 1 is a Win 7 machine, and Client 2 I have tried a Win 7 and
OSX machine. In both cases the behavior is repeatable.

- All clients are on IPv4 only.

- I ran a Wireshark cap on the roaming client - no gratuitous ARP
replies seen during the roam

- Client 2 is doing the pinging to Client 1

- The problem is permanent, and can be fixed by one of the below:
  - Manually delete the roaming client via 'iw station del'
  - Restart node A network stack (/etc/init.d/network restart), but
which client attaches to which AP is not deterministic.
  - Client 2 roams back to A

- I tried 'brctl setaging 0' on node A's bridge, that didn't affect the beh=
avior

- Running 'iw station get' on the 2 nodes during the problem yields
some interesting results. On both nodes, the inactive time resets to 0
while the ping is running. If I stopped the ping, the inactive time on
both nodes will rise as expected.

- Even more strange with 'iw station get' during the problem:
interacting with the Telnet connection from Client 2 to Node A will
also reset the inactive time count for Client 2, and this is while
Client 2 is roamed to node B. On node A, only the tx {bytes, packets}
counters will increase. rx counts do not. On node B, the tx/rx counts
increase as expected.

- I am in a relatively small area, so even if Client 2 roamed to B, it
is still within RF range of both nodes.

I mentioned before that both nodes' local translation tables were
accurate after the roam. I also mentioned that doing a 'iw station
del' will fix the problem. So, I took advantage of this and wrote a
quick hack script to verify. The pseudo code is as follows:

while true
  run batctl tl and get current local client list
  compare current local client list with the last client list
  if (old list has clients that the new list doesn't have)
    run iw station del for those clients
  save current list to last client list
  sleep
done

Terrible hack, but I was able to roam successfully while this script is run=
ning.

Thanks,

- Simon

On Tue, Jul 1, 2014 at 4:26 AM, Antonio Quartulli
<antonio@meshcoding.com> wrote:
>
>
> On 01/07/14 10:50, Linus L=C3=BCssing wrote:
>> It could be a problem with a not yet updated MAC address table in
>> the bridge, therefore the bridge on node A not forwarding ICMP
>> requests from client 1 towards client 2.
>>
>
> Hey Linus,
>
> I agree that the problem is probably in the bridge, but how can it be an
> inconsistency in the table given that the bridge is receiving the Echo
> requests from client 2 through bat0?
>
> Shouldn't this immediately update the bridge table to reflect the client
> movement (client2 --is-behind--> bat0)?
>
>
> @Simon: are you sure that the client is not associated anymore with node
> A at that moment (maybe it was jumping here and there)? You said that
> you can fix situation this by deleting the station entry, but is this
> station entry obsolete at that point? (meaning: is the inactivity time
> high? - you can see this through the "iw dev wlan0 station get <client2
> mac>" command before deleting it)
> If not, it can be that something wrong is happening at the wifi layer
> and given the driver you are using (ath5k) it would not be totally
> unexpected.
>
> I am asking this because I expect the station to disappear immediately
> in case of roaming (the client usually deauthenticates itself before
> associating with the new AP). Still, we can have cases when this does
> not happen, but the AP should be able to react properly.
>
>
> Cheers,
>
> --
> Antonio Quartulli
>
