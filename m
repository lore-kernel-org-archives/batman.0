Return-Path: <emilgoode@gmail.com>
Message-ID: <1360187945.25903.5.camel@debian>
From: Emil Goode <emilgoode@gmail.com>
Date: Wed, 06 Feb 2013 22:59:05 +0100
In-Reply-To: <20130206195557.GC6008@ritirata.org>
References: <1360168661-16871-1-git-send-email-emilgoode@gmail.com>
 <20130206172234.GB6008@ritirata.org> <1360173353.22154.4.camel@debian>
 <20130206195557.GC6008@ritirata.org>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove unused variable
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, siwu@hrz.tu-chemnitz.de, lindner_marek@yahoo.de, davem@davemloft.net

Hi Antonio,

If it is easier I can keep an eye on when the commit lands in the
net-next tree and then resend a modified version of the patch.
Or do you want me to resend it now?

Best regards, Emil

On Wed, 2013-02-06 at 20:55 +0100, Antonio Quartulli wrote:
> Hi Emil,
> 
> On Wed, Feb 06, 2013 at 06:55:53 +0100, Emil Goode wrote:
> > Hi Antonio,
> > 
> > The commit ed242d01 is in the linux-next tree and my patch depends on
> > that commit.
> > 
> 
> Yes, you are right. I was not aware of this commit, because the author
> did not CC us (neither netdev) even if he changed the code we maintain.
> 
> As far as I can see that commit is in linux-next only.
> Therefore it must be applied there.
> 
> However, I'd like you to change the commit message and write the full hash of
> the commit you are referring to and its subject ("LIKE THIS"). This would make
> it easier to find it.
> 
> 
> Regards,
> 
> > Best regards, Emil
> > 
> > On Wed, 2013-02-06 at 18:22 +0100, Antonio Quartulli wrote:
> > > Hi Emil,
> > > 
> > > On Wed, Feb 06, 2013 at 05:37:41 +0100, Emil Goode wrote:
> > > > The commit ed242d01 removed a node parameter from iterators.
> > > > This patch removes a hlist_node struct that is no longer used.
> > > > 
> > > > Sparse gives a warning:
> > > > 
> > > > net/batman-adv/originator.c:411:21: warning:
> > > > 	unused variable ‘node_tmp’ [-Wunused-variable]
> > > > 
> > > > Signed-off-by: Emil Goode <emilgoode@gmail.com>
> > > 
> > > On which tree did you base your patch?
> > > I cannot find the commit you are referring to (ed242d01) and the patch does not
> > > apply (neither on net nor net-next).
> > > 
> > > Other than that the variable is used a couple of lines below (in the code we
> > > have)...
> > > 
> > > Regards,
> > > 
> > 
> > 
> 


