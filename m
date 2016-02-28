Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1456679847.1958.52.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Sun, 28 Feb 2016 18:17:27 +0100
In-Reply-To: <10118093.UzH4NL7sLW@sven-edge>
References: <1456616348.1958.16.camel@gmail.com>
 <10118093.UzH4NL7sLW@sven-edge>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batctl: page allocation failure
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

Hi Sven,

as already mentioned the failure does not happen any more. I'm sorry
bothering you with this unreproducible issue.

Am Sonntag, den 28.02.2016, 17:23 +0100 schrieb Sven Eckelmann:
> On Sunday 28 February 2016 00:39:08 Philipp Psurek wrote:
> > Hi all,
> > 
> > I've got this error with
> [..]
> > 
> > 
> > ----------------------------------
> [..]
> > [Feb28 00:13] batctl: page allocation failure: order:4, mode:0x40d0
> 
> Does this always happen when you use `batctl o` on a system with many 
> entries in the originator table?

I never saw this failure before. Executing 

# batctl o | wc -l
338

on an 32 MiB RAM router was never a problem.  I thought it would be the best reporting this issue.

> When yes, then you could try the attached (very rough) proof-of
> -concept patch. It is based on v2016.0-92-gd7c9a9e

You are a faster coder than me as email writer. I'll implement the
Patch in your 2nd email and report.

Best regards,
  Philipp

