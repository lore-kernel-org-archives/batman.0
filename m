Return-Path: <shanwei88@gmail.com>
Message-ID: <5094A485.4060409@gmail.com>
Date: Sat, 03 Nov 2012 12:58:45 +0800
From: Shan Wei <shanwei88@gmail.com>
MIME-Version: 1.0
References: <5093EE7E.6040400@gmail.com> <5905519.yWN2Ke3YlE@bentobox>
In-Reply-To: <5905519.yWN2Ke3YlE@bentobox>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 9/9] net: batman-adv: use per_cpu_add
 helper
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
To: Sven Eckelmann <sven@narfation.org>
Cc: NetDev <netdev@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, Kernel-Maillist <linux-kernel@vger.kernel.org>, siwu@hrz.tu-chemnitz.de, Christoph Lameter <cl@linux.com>, lindner_marek@yahoo.de, David Miller <davem@davemloft.net>

Sven Eckelmann said, at 2012/11/3 1:55:
> On Saturday 03 November 2012 00:02:06 Shan Wei wrote:
>> From: Shan Wei <davidshan@tencent.com>
>>
>> As Christoph Lameter said:
>>> In addition, following usage of per_cpu_ptr can be replaced by
>>> this_cpu_read.
>>>
>>> cpu=get_cpu()
>>> ....
>>> *per_cpu_ptr(p,cpu)
>>> ....
>>> ....
>>> put_cpu()
>>
>> Right.
>>
>> Signed-off-by: Shan Wei <davidshan@tencent.com>
>> ---
> 
> Is this really supposed to be the commit message?

Maybe it's ok when Linus said this. :-)

Christoph is the maintainer of per-cpu.
So........

PER-CPU MEMORY ALLOCATOR
M:      Tejun Heo <tj@kernel.org>
M:      Christoph Lameter <cl@linux-foundation.org>
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu.git
S:      Maintained
F:      include/linux/percpu*.h
F:      mm/percpu*.c
F:      arch/*/include/asm/percpu.h

> 
> Kind regards,
> 	Sven
> 

