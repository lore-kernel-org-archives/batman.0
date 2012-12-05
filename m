Return-Path: <moritzwarning@web.de>
Message-ID: <50BE947B.1090800@web.de>
Date: Wed, 05 Dec 2012 01:25:31 +0100
From: Moritz Warning <moritzwarning@web.de>
MIME-Version: 1.0
References: <50BE9250.2050303@web.de>
In-Reply-To: <50BE9250.2050303@web.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: output errors to stderr
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

Before someone asks - yes, it compiles and appears to work as intended.

On 12/05/2012 01:16 AM, Moritz Warning wrote:
> batctl outputs many errors to stdout instead of stderr.
> This patch corrects this behavior by redirecting errors
> and the usage texts to stderr.
> 
> Signed-off-by: Moritz Warning <moritzwarning at web.de>
> ---
[..]

