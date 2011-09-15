Return-Path: <clownix@clownix.net>
Message-ID: <2717fdb7febe29366a2edbc9d77ee2fb.squirrel@clownix.net>
In-Reply-To: <1618735.6vzXCZcuLY@sven-desktop.home.narfation.org>
References: <c3913757cea624537f48fb88fb60e913.squirrel@clownix.net>
	<14791148.Lch9XMektA@sven-desktop.home.narfation.org>
	<d477c5ac8b5c4fea9529957152699501.squirrel@clownix.net>
	<1618735.6vzXCZcuLY@sven-desktop.home.narfation.org>
Date: Thu, 15 Sep 2011 09:39:51 -0500
From: clownix@clownix.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] lxc and batman
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

All is now clear, I have no idea about how namespaces work and neither
about the batman-adv instances, I am a simple user preparing for a future
batman-adv demo network on a single PC.
This information is what I wanted, so thanks a lot.
I agree that I do not see any other usage scenario than demo-scenario.

Kind Regards
Vincent


> On Thursday 15 September 2011 08:40:15 clownix@clownix.net wrote:
>> So, for the multiplication of machines in a big network, you confirm
>> that
>> batman-adv is not compatible with lxc.
>
> I never said that it is not compatible with lxc
>
>> However something is still not clear: with one batman-adv per namespace,
>> would it be possible to have what you have with kvm but with lxc?
>
> No, this is not possible by definition. kvm == multiple batman-adv
> instances,
> batman-adv in lxc == one instance with interfaces in different namespaces.
>
>> The gain for this work would be only performance, the useful scenario
>> being no other than what you have with kvm: big (independant) networks.
>
> No, by definition those networks aren't independent as they share
> resources
> inside batman-adv (and many other resources).
>
> As far as I understand: You want to create batman-adv interfaces in
> different
> namespaces without having colliding names. Feel free to submit patches for
> it
> (or enthuse some developers with spare time).
>
> But I am still waiting for an actual usage scenario. KVM is mostly used
> for
> debugging purposes... something were we want to have separate instances
> which
> don't crash the developer machine. And I don't see the reason for having
> the
> overhead of batman-adv in all namespaces instead of a single entry/exit
> point.
>
> Kind regards,
> 	Sven

