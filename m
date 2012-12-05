Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 6 Dec 2012 01:40:48 +0800
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201212060140.48732.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] RFC: Removing one indirection layer for patches
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


Hi,

[trimmed long explanation of how things are done today]

> Antonio already showed that he can handle adhoc pull requests very well.
> Therefore, the idea would be to remove the two month extra waiting time.
> Here are just two random branch names:
> 
> * next - new patches are excepted here - so it is something like net-next
> for batman-adv. Antonio will gather some patches and then sent them to
> David. Davids reaction will come heavy and hard... but the effort for an
> reaction is reduced.
> * master - bugfix gathering place. So it is like net for batman-adv.
> Patches will end up really fast in Linus' tree.

I am a little confused here. Our "next" branch will be the new "master" and 
the new "master" will be what "maint" is today ?

I also don't see the implementation of the new merge policy yet. David can 
only receive what we merged before but how do we determine what patch to merge 
when and how ? Up to now there was a simple rule (spawned from your head 
iirc): Features into master, cleanups into master, fixes for next into next 
and very critical stuff into maint. How is that supposed to work in the 
future?

One very vocal voice keeps telling me: Just merge everything into the "new 
next" - the rest will fall into place. No need to worry. 

However, it would be great if your suggestion could be contemplated by such a 
merge policy. I don't see it yet. It would be even better if those who believe 
to know how it all will work out stepped up and took the job of collecting & 
merging the patches into the "new next". I certainly would not mind.

Cheers,
Marek
