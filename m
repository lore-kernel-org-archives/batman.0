Return-Path: <emilgoode@gmail.com>
Message-ID: <1360173353.22154.4.camel@debian>
From: Emil Goode <emilgoode@gmail.com>
Date: Wed, 06 Feb 2013 18:55:53 +0100
In-Reply-To: <20130206172234.GB6008@ritirata.org>
References: <1360168661-16871-1-git-send-email-emilgoode@gmail.com>
 <20130206172234.GB6008@ritirata.org>
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

The commit ed242d01 is in the linux-next tree and my patch depends on
that commit.

Best regards, Emil

On Wed, 2013-02-06 at 18:22 +0100, Antonio Quartulli wrote:
> Hi Emil,
> 
> On Wed, Feb 06, 2013 at 05:37:41 +0100, Emil Goode wrote:
> > The commit ed242d01 removed a node parameter from iterators.
> > This patch removes a hlist_node struct that is no longer used.
> > 
> > Sparse gives a warning:
> > 
> > net/batman-adv/originator.c:411:21: warning:
> > 	unused variable ‘node_tmp’ [-Wunused-variable]
> > 
> > Signed-off-by: Emil Goode <emilgoode@gmail.com>
> 
> On which tree did you base your patch?
> I cannot find the commit you are referring to (ed242d01) and the patch does not
> apply (neither on net nor net-next).
> 
> Other than that the variable is used a couple of lines below (in the code we
> have)...
> 
> Regards,
> 


