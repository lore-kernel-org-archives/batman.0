Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <5282CE44.8000402@altermundi.net>
Date: Tue, 12 Nov 2013 21:56:36 -0300
From: =?UTF-8?B?Tmljb2zDoXMgRWNow6FuaXo=?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <525B11F2.5030605@altermundi.net>
 <5282A184.1020704@altermundi.net> <20131112215442.GN3713@neomailbox.net>
In-Reply-To: <20131112215442.GN3713@neomailbox.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] mad mad batman ...
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El 12/11/13 18:54, Antonio Quartulli escribió:
> Hi Nico,
> 
> I have no real clue, but is it possible that there is a loop
> somewhere? I imagine you have checked already..but I can't come
> with something more useful at the moment..

Ok, I've spent the afternoon turning off semi-inaccessible nodes one
by one until I found the one causing the problem.

It's installed on a public lighting post, so it may take a while to
take it down for inspection.

I don't know if you guys remember I had brought to the battlemesh a
crazy node (nicknamed Jocker), that started misbehaving after a
lightning bolt hit nearby. The symptom was the same I observed now:
every node in the net would start repeatedly showing the message:
"received packet on bat0 with own address as source address".

I was in Europe during the time this second node started behaving like
this so I still don't know much about the moment it started.

Do you think this matter could be addressed at batman level somehow?
In a 50 node network this is already quite difficult to diagnose. I
can't imagine how a bigger network where no single person has remote
access to every node would coordinate to isolate the problematic router...

If you are interested in looking at this first hand we can try to set
up an isolated test-bed with IPv6 connectivity for you to log in and
play around.

Am I the only one who has bumped into this (twice)?

cheers.


> On Tue, Nov 12, 2013 at 06:45:40PM -0300, Nicolás Echániz wrote:
>> 
>> back in Quintana... this problem is still showing in every node.
>> The network is unstable and so it's difficult to debug. If anyone
>> has a clue as to where to look for the origin I'll be glad to
>> read your thoughts.
>> 
>> cheers, Nico
>> 
>> 
>> El 13/10/13 18:34, Nicolás Echániz escribió:
>>> While I'm still in Europe I've observed that the network in
>>> Quintana has started performing very poorly today. It was
>>> working perfectly fine until yesterday.
>>> 
>>> The logs on every router have started showing entries like
>>> these:
>>> 
>>> Oct 13 18:09:43 frigorifico kern.warn kernel: [12018.150000]
>>> br-lan: received packet on bat0 with own address as source
>>> address Oct 13 18:09:45 frigorifico kern.warn kernel:
>>> [12020.040000] br-lan: received packet on bat0 with own address
>>> as source address Oct 13 18:09:45 frigorifico kern.warn kernel:
>>> [12020.040000] br-lan: received packet on bat0 with own address
>>> as source address Oct 13 18:09:45 frigorifico kern.warn kernel:
>>> [12020.550000] br-lan: received packet on bat0 with own address
>>> as source address Oct 13 18:09:45 frigorifico kern.warn kernel:
>>> [12020.550000] br-lan: received packet on bat0 with own address
>>> as source address Oct 13 18:09:45 frigorifico kern.warn kernel:
>>> [12020.570000] br-lan: received packet on bat0 with own address
>>> as source address Oct 13 18:09:45 frigorifico kern.warn kernel:
>>> [12020.580000] br-lan: received packet on bat0 with own address
>>> as source address Oct 13 18:09:46 frigorifico kern.warn kernel:
>>> [12021.040000] br-lan: received packet on bat0 with own address
>>> as source address
>>> 
>>> As you can see there are many per second.
>>> 
>>> 
>>> I've pasted a bit of batctl ll batman; batctl log here:
>>> 
>>> http://pastebin.com/HX1LBPK4
>>> 
>>> 
>>> ...it's only showing the "originator packet from myself" lines
>>> and one line before. (the sample is less than 5 secs of logs)
>>> 
>>> Every node I checked is showing the same.
>>> 
>>> 
>>> Last time this happened it was due to a router that had been
>>> affected by a nearby lightning bolt. The switch went crazy. It
>>> took a while to detect it and the network was 15 nodes big. Now
>>> it's 40 and we are quite far away :)
>>> 
>>> 
>>> If anyone has an idea of how to better test where the problem
>>> is originated, I'll be glad to hear it. Also if any batman
>>> devel wishes to log in to the net to check first hand, just let
>>> me know.
>>> 
>>> 
>>> Cheers! Nico
>>> 
>>> 
>>> PS: batman version is 2012.4
>>> 
>> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iQEcBAEBAgAGBQJSgs47AAoJEPHORz17N0TF/BsH/0R+d/k10hrPDOb6zX5rwkZJ
oSbqjrBttmBRAJFGJ2hywFXm0nnL8Teo696Ulrf8wuh9wrl6aR9MD/fsrKdyfPM+
/+MTKGb6uak20Kb5pbUY+8/xl+ZmtmWkXlolEdT/PFsFFh+Ap4EiMgQIDr64EXZq
IF6AkFFuNv/Oovc3COnlY+gWhxton+DRNKoHpZw37h46jTH6zSy0MATIIGKueS44
2zVpuEgbkyUVvyJYKhBt9GjX5SGQ4TVBMX0EnZuN/bEk2al64EiEOySjUYvf3xTD
iqRWbvyloPZi5mhgEI876gt5qTDXmcs6YjEsvpOU+YiZoawtIAI1J8vo3kUzdBs=
=APtL
-----END PGP SIGNATURE-----
