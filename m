Return-Path: <gwirth79@gmail.com>
Message-ID: <4B61351A.5030605@gmail.com>
Date: Wed, 27 Jan 2010 22:56:26 -0800
From: Gus Wirth <gwirth79@gmail.com>
MIME-Version: 1.0
References: <5522db2e1001261326g7068972fq9c82780bcf5dc99e@mail.gmail.com>
In-Reply-To: <5522db2e1001261326g7068972fq9c82780bcf5dc99e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv and IPSec
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

On 01/26/2010 01:26 PM, ecfu wrote:
> Can I use IPSec with batman-adv?  Has anyone ever done this?  Is there
> anything special that needs to be done or because I am using batman-adv,
> this is transparent?

IPSec is basically IP inside IP. Since batman-adv works on the layer 2
level (ethernet frames) you shouldn't have to worry about. It should
"Just Work"

Gus
