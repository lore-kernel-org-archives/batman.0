Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CAHD-aqJUX0LxRfxrqJL4-oc7+QxLRdfiHikY40FvafL3pgEUyw@mail.gmail.com>
References: <CAHD-aqJUX0LxRfxrqJL4-oc7+QxLRdfiHikY40FvafL3pgEUyw@mail.gmail.com>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Mon, 2 Jul 2012 10:57:57 -0300
Message-ID: <CAHD-aqK-SrQ0VxmrZSzq3gb_aVZQY5ZYxN7qjdC8dind+jgeuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] batman majareta? I can batctl ping but not ping
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> I used arping, with and without -b , and seemed like i could narrow
> the problem down to incoming broadcast packet handling, but further
> tests just left me more puzzled!

Well, seems colmena is the uncooperative bathost
another log:
http://pastebin.com/FMD9Lieq
that can be summarized as follows

### From COLMENA-CASA, can ping bochita but not ana
### From PEREYRA, can ping bochita but not ana
### From COLMENA, works perfect to both destinations

colmena-casa and pereyra must pass through colmena, which is for some
reason allowing batctl pings , ogms , and whatnot passthrough in its
way to ana, but no ICMP echo requests, or tcp traffic whatsoever if
it's final destination is ana.
if final destination is bochita, everything works as expected.

Any ideas?

I'm going to delay rebooting colmena as long as i can, in case someone
comes up with an insightful test to run :)

Gui
