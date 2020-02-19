Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: can't find logged information
Date: Wed, 19 Feb 2020 10:50:35 +0100
Message-ID: <2230258.gT3E0N9OL2@prime>
In-Reply-To: <a687012a-8857-22f3-0623-d82bad19e7bc@coolheads.com>
References: <24aa48bb-8f52-78be-28df-98ec2e2a054b@coolheads.com>
 <1851274.gzzsXW5Q3G@prime>
 <a687012a-8857-22f3-0623-d82bad19e7bc@coolheads.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2822093.mmKloyyKZI";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: srn@coolheads.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2822093.mmKloyyKZI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Steve,

On Tuesday, February 11, 2020 8:03:32 PM CET Steve Newcomb wrote:
> First a report about trace-cmd.  It's not working right, I think, in the
> bleeding-edge ("trunk") distribution of OpenWRT that I'm using.
> 
> Then, in case you are inclined to respond, below are some
> observations/questions about the loss-of-contact I'm experiencing in my
> meshes.
> 
> ---------------------------------------------
> 
>   I tried setting 'batctl ll bla'.  (I suspect something to do with
> bridge loop avoidance may be what's killing our meshes.)  After that,
> the cat /sys/kernel/debug/batman_adv/bat0/log method works pretty well,
> but the trace-cmd method produces little or nothing.
> 
> root@rpc152:~# trace-cmd stream -e batadv:batadv_dbg
> trace-cmd: Invalid argument
>    [cfg80211:cfg80211_tx_mlme_mgmt] function __le16_to_cpup not defined
> trace-cmd: Invalid argument
>    [cfg80211:cfg80211_rx_unprot_mlme_mgmt] function __le16_to_cpup not
> defined
>    [cfg80211:cfg80211_rx_mlme_mgmt] function __le16_to_cpup not defined
> Hit Ctrl^C to stop recording
> 
> [the above lines appear to be coming from stderr]
> 
> [... here I wait a long time, and there's no output, so eventually I
> grow impatient and I interrupt ...]
> 
> ^C^Croot@rpc152:~#
> 
> ----------------------------------------------
> 
> Sometimes after interrupting I get a few lines of bridge-loop-avoidance
> log entries; here is such a case:
> 
> @rpc152:/root# trace-cmd stream -e batadv:batadv_dbg
> trace-cmd: Invalid argument
>    [cfg80211:cfg80211_tx_mlme_mgmt] function __le16_to_cpup not defined
> trace-cmd: Invalid argument
>    [cfg80211:cfg80211_rx_unprot_mlme_mgmt] function __le16_to_cpup not
> defined
>    [cfg80211:cfg80211_rx_mlme_mgmt] function __le16_to_cpup not defined
> Hit Ctrl^C to stop recording
>    C-c C-c          <idle>-0     [000] 81408.634044:
> batadv_dbg:           batman_adv bat0 batadv_bla_process_claim():
> received a claim frame from another group. From: 0c:80:63:e1:59:40 on vi\
> d 1 ...(hw_src 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
>             <...>-4595  [000] 81409.423996: batadv_dbg:          
> batman_adv bat0 batadv_bla_purge_claims(): timed out.
>             <...>-4595  [000] 81409.424016: batadv_dbg:          
> batman_adv bat0 batadv_bla_purge_claims(): 5c:1d:d9:54:09:8f, vid 32769
>             <...>-4595  [000] 81409.424034: batadv_dbg:          
> batman_adv bat0 batadv_bla_send_claim(): UNCLAIM 5c:1d:d9:54:09:8f on vid 1
>             <...>-4595  [000] 81409.424053: batadv_dbg:          
> batman_adv bat0 batadv_handle_unclaim(): UNCLAIM 5c:1d:d9:54:09:8f on
> vid 1 (sent by 50:c7:bf:69:bb:17)...
>             <...>-4595  [000] 81409.424065: batadv_dbg:          
> batman_adv bat0 batadv_bla_del_claim(): 5c:1d:d9:54:09:8f, vid 1
>             <...>-4595  [000] 81409.424092: batadv_dbg:          
> batman_adv bat0 batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17
> on vid 1
>            <idle>-0     [000] 81418.874031: batadv_dbg:          
> batman_adv bat0 batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(h\
> w_src 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
>             <...>-4595  [000] 81419.663601: batadv_dbg:          
> batman_adv bat0 batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17
> on vid 1
> @rpc152:/root#
> 
> ------------------------------------------------
> 
> With the cat /sys/kernel/debug/batman_adv/bat0/log method of
> log-reading, there's generally oodles of output.  At first it comes all
> in a rush, and then it continues more slowly but still pretty steadily:
> 
> @rpc152:/root# cat /sys/kernel/debug/batman_adv/bat0/log
> [  81068650] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81069440] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81078890] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81079680] batadv_bla_purge_claims(): timed out.
> [  81079680] batadv_bla_purge_claims(): 64:c7:53:e6:f8:ae, vid 32769
> [  81079680] batadv_bla_send_claim(): UNCLAIM 64:c7:53:e6:f8:ae on vid 1
> [  81079680] batadv_handle_unclaim(): UNCLAIM 64:c7:53:e6:f8:ae on vid 1
> (sent by 50:c7:bf:69:bb:17)...
> [  81079680] batadv_bla_del_claim(): 64:c7:53:e6:f8:ae, vid 1
> [  81079680] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81079680] Send loopdetect frame for vid 32769
> [  81079680] batadv_bla_send_claim(): LOOPDETECT of ba:be:22:e0:3f:ec to
> ff:ff:ff:ff:ff:ff on vid 1
> [  81089130] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81089920] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81099370] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81100160] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81109610] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81110400] batadv_bla_purge_claims(): timed out.
> [  81110400] batadv_bla_purge_claims(): 5c:1d:d9:54:09:8f, vid 32769
> [  81110400] batadv_bla_send_claim(): UNCLAIM 5c:1d:d9:54:09:8f on vid 1
> [  81110400] batadv_handle_unclaim(): UNCLAIM 5c:1d:d9:54:09:8f on vid 1
> (sent by 50:c7:bf:69:bb:17)...
> [  81110400] batadv_bla_del_claim(): 5c:1d:d9:54:09:8f, vid 1
> [  81110400] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81119850] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81120640] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81130090] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81130880] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81140330] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81141120] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81141120] Send loopdetect frame for vid 32769
> [  81141120] batadv_bla_send_claim(): LOOPDETECT of ba:be:e5:06:19:6e to
> ff:ff:ff:ff:ff:ff on vid 1
> [  81150100] batadv_bla_rx(): Unclaimed MAC 5c:1d:d9:54:09:8f found.
> Claim it. Local: no
> [  81150100] batadv_bla_add_claim(): adding new entry 5c:1d:d9:54:09:8f,
> vid 1 to hash ...
> [  81150100] batadv_bla_send_claim(): CLAIM 5c:1d:d9:54:09:8f on vid 1
> [  81150570] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81151360] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81160810] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81161600] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81171050] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81171840] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81181290] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81182080] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81191530] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81192320] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81201770] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81202560] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81202560] Send loopdetect frame for vid 32769
> [  81202560] batadv_bla_send_claim(): LOOPDETECT of ba:be:bb:25:c7:93 to
> ff:ff:ff:ff:ff:ff on vid 1
> [  81212010] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81212800] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81222250] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81223040] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81232490] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81233280] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> [  81242730] batadv_bla_process_claim(): received a claim frame from
> another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src
> 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
> [  81243520] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vid 1
> 
> -------------------------------------------------------------------------
> 
> ...so if I were you I wouldn't hurry to remove
> /sys/kernel/debug/batman_adv/bat0/log.  The trace-cmd stuff doesn't
> appear to work quite correctly yet.


OK, thank you for reporting this!

> 
> -----------------------------------------------------------------------
> 
> Now my first question is: what does it mean to have a
> 
> "LOOPDETECT of ba:be:aa:c0:d6:bf to ff:ff:ff:ff:ff:ff"
> 
> ?

This means that your node has sent a LOOPDETECT packet. Those are sent out on 
the LAN to check if there is a loop somewhere which BLA couldn't resolve or 
where a misconfiguration happened. There are some scenarios which are not 
covered by BLA:

https://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance-II#Limitations

> 
> -----------------------------------------------------------------------
> 
> When nodes become unreachable, they do so only partially.  Consider this
> weirdness I encountered two days ago:  Given nodes a, b, c, d, from the
> perspective of a, d has disappeared; in other words, "a# batctl ping d"
> doesn't work.  But I ssh'd from a to b, then from b to c, then from c to
> d, all successfully.  And "a# batctl ping d" still wasn't working, even
> though I was talking to d through that chain of ssh pipes.  Any ideas on
> what that might mean?  (When I reboot a -- the gateway -- everything
> always works again, usually for many hours, but never as long as a whole
> day.)

Hmm, that's strange indeed. Did you have good connection between all those 
devices? There is a certain "horizon", e.g. if you have many weak links in a 
daisy chain the the OGMs are dropped before they are reaching the end of the 
path.

Did you see node D in the originator table of node A?

> 
> Assuming some mischief is being done in bridge-loop-avoidance-land, and
> bearing in mind that both meshes are physically laid out as simple
> linear daisy-chains, is there a way to force each node to ignore all
> nodes other than its immediate lefthand and righthand nodes?  If that's
> possible, it might allow an interesting experiment.

We don't have an option to ignore nodes from a user perspective.

> 
> ----------------------------------------------------------------------
> 
> Do I have a problem because the two meshes, and everything connected to
> them, all share the same LAN?  I note "received a claim frame from
> another group" in the above log excerpt.  (I don't know what that means,
> but I'm guessing that the two meshes are getting each other's
> maintenance traffic.)  Should the two meshes be separate subnets?

It's possible and perfectly fine if you have two meshes connected to the same 
LAN like this:

https://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance-Testcases#Two-meshes-connected-by-one-LAN

Just make sure that the meshes are properly disconnected and not rejoin from 
time to time (e.g. by having different SSIDs)

> 
> In a similar vein: Should each node be running its own subnet?
> 
> ----------------------------------------------------------------------
> 
> Should I try changing all nodes over to BATMAN_V, rebooting them all,
> and hoping they re-establish contact?  (It would be massively
> inconvenient to have to reset them all physically.)

No, BATMAN V will not magically fix this.

> 
> ----------------------------------------------------------------------
> 
> Should I try turning off bridge loop avoidance?

bridge loop avoidance should be on as soon as you have any two nodes connected 
to the same LAN and mesh at one time.
> 
> ---------------------------------------------------------------------
> 
> Should I try turning on ap_isolation?

I don't see why you need ap_isolation. This is for external stations which are 
connected to APs of the same mesh and shouldn't talk to each other.

> 
> ---------------------------------------------------------------------
> 
> Any other ideas?

I think we should work on your a - b - c - d chain and find out why a can't 
talk to d. That seems like the most obvious symptom.

Cheers,
      Simon


> 
> On 2/7/20 12:07 PM, Simon Wunderlich wrote:
> > On Friday, February 7, 2020 5:59:27 PM CET Steve Newcomb wrote:
> >> On 2/7/20 10:52 AM, Simon Wunderlich wrote:
> >>> Oops, you are right, we have actually removed that command in 2019.2.
> >>> You
> >>> can use one of the two following commands:
> >>> 
> >>> cat /sys/kernel/debug/batman_adv/bat0/log
> >> 
> >> The cat method works.  Thanks.  Wow, with all the debug info selected,
> >> it's a torrent of stuff.  (Which I expected.)
> > 
> > Awesome
> > 
> >>> (will be removed in the future when debugfs support is dropped
> >>> 
> >>>    trace-cmd stream -e batadv:batadv_dbg
> >> 
> >> Uh, *which* of the two above commands will be dropped?  Should I add
> >> trace-cmd to my menuconfig to retain access to the logs?  I haven't
> >> added it yet.
> > 
> > the /sys/kernel/debug/batman_adv/bat0/log file will be removed in the
> > future. So yes, add the trace-cmd
> > 
> >>   > By "works" you mean you get useful outputs where the timeout is not
> >> 
> >> increasing or similar? can you still "batctl ping" to one of your
> >> neighbors?
> >> 
> >> You are far ahead of where I am.  I meant only that I was getting what
> >> appears to be useful information, not that I have interpreted it.  It
> >> will take me a while to figure out how to read it.  I would be grateful
> >> for any hints on that, and I'm already very grateful for the help you
> >> have provided.
> >> 
> >> I haven't been using "batctl ping" to cue a reboot; I've been using
> >> "ping".  I'm not sure what difference it might make to use "batctl
> >> ping"; it seems to me that if I can't "ping" a node, after 3 or 4 trials
> >> over a period of 15-20 seconds, I'm no longer in touch with it in any
> >> usable way.  When that happens, as long as I don't reboot the gateway,
> >> everything just stays offline.  So it's better to reboot.
> >> 
> >> By the way, at least one user is using the mesh for landline telephone
> >> (Google Voice) service, so I'd really like to stabilize it if I can.
> > 
> > So in iw station dump and and batctl neighbor table, there is a "last
> > seen"
> > field or "inactive time". Usually those fields should be < 5 seconds or
> > so, if they rise then it means this station has been lost somehow.
> > 
> > The difference between batctl ping and a regular ping is that the batctl
> > ping is actually implemented INSIDE of batman-adv, so it will be used to
> > ping a certain mesh participant. Therefore batctl ping relies on less
> > "moving parts" such as correctly configured IPs, MAC address translation,
> > etc. If batctl ping works but regular ping doesn't then we know something
> > on the Ethernet transport part is off. The other way around (batctl ping
> > doesn't work but regular ping does) is pretty much impossible unless the
> > user does something wrong. If batctl ping to a neighbor doesn't work,
> > it's likelythe Wifi layer or something else is exhibiting problems or
> > batman-adv is not set up correctly.
> > 
> > Cheers,
> > 
> >         Simon


--nextPart2822093.mmKloyyKZI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAl5NBOsACgkQoSvjmEKS
nqHujBAAmPXohLk8oUk+neafVJZrHntuwkkSAuLue1xZia3i/ffqkLbdAamhmJWP
n7EkgiM0Dlo7cH2n0+s+1iBzU1LLSMF07ObU9SLitFa28VFh5G/VqfI7Cl1lw7Lt
wYQJt8Ka5QEcunbMB3HbtTo6PYFuARr+lzLNPubxZWwtC6qM2Sue6uqDEnG6CkDX
QwrJVnnc3J74+JKs81rV4ETAqrRb7iZnnIKinaL7CNJFj6TGpyHKyL4uDA7O9J5u
inB+IodNxrjEk5uEuLm7EQ3D8BgKq1j7r5sqharNKGDI3ZxI/UE2uAd+rEAbeGpB
zcWrKMGSUbW6exW01SBndmeI5mNpqG+vfGtfWzHX5PAwXI9vxu6iF8wezXzPB+9m
TDuXZBzMfWG5M6vAdRFfFzEjtS3uyH6VSs13q8Cmt3PIhSiwMekkqdrfH42hN9pm
9+J8VxjvbgSnz+mvq3ZLYmR0pjuQTITz73+UJhkLGwG5FSGNbYORl3SrdjEMW8Xn
OIsfHLLHT3x9R2ds/q5texT5j3dohJGg1zOhVpvU32HXGgoccWM8O9sFSFRs0U+a
xG+gjhTmMwmL3t3EN3Ee/HG/OlQOcdWRruE4a4jMlXGRgIx8UDKyfNrLwR/nhJXC
d1kepydP6RzSenf1jSe37FUsE0OOdbegADD1XZxuTSrPC7Xv1+4=
=uljj
-----END PGP SIGNATURE-----

--nextPart2822093.mmKloyyKZI--



