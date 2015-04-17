Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Apr 2015 20:03:06 +0200
Message-ID: <2017856.ZSEBf5EYJq@bentobox>
In-Reply-To: <13114664.Eg4ODy7KEo@bentobox>
References: <13114664.Eg4ODy7KEo@bentobox>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 0/6] Patches for batman-adv 2015.0
	release
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Friday 17 April 2015 18:32:45 Sven Eckelmann wrote:
[...]
> Releases
> ~~~~~~~~
> 
> I was also under the impression that no one really knew what will be
> released and what version of the kernel tree it will be based on. How about
> changing the Release-todo (see attached image)
> 
>  * maint branch is released as feature release 2015.a after linux 4.x
>    is tagged
>  * 2015.a.y branches are released on demand... most likely never
>  * content of master becomes new maint after release

Meant was "content of master becomes new maint after current maint was 
released".

It may also be important to understand that new features in master after the 
net-next.git merge window closed should not become part of the new maint 
because they cannot be pushed to David for the next 4.x version. But this is 
not a real technical problem because the maint must not really jump to the 
latest position of the master branch HEAD - it is possible to choose a 
slightly older position and still get a fast-forward merge in git.

Kind regards,
	Sven
