Return-Path: <don@dis.org.nz>
MIME-Version: 1.0
In-Reply-To: <20121001210650.GB15826@pandem0nium>
References: <CAK+uisD5AddOnF+o5U4LdFu+7CAnNCJna8wBZL1huHqZyeLOfg@mail.gmail.com>
 <20121001210650.GB15826@pandem0nium>
Date: Fri, 16 Nov 2012 12:04:08 +1300
Message-ID: <CAK+uisAU3eakeuWkuWXR676vpzdoXtM42uM+A-nTM-73d-G9jQ@mail.gmail.com>
From: Donald Gordon <don@dis.org.nz>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] batman-adv on ethernet
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

Hi

(sorry for the very late reply)

On Tue, Oct 2, 2012 at 10:06 AM, Simon Wunderlich
<simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> You are about to enable batman-adv on 'eth0' which already is part of a bridge. Unless you know exactly what you are doing this is probably wrong and won't work the way you think it would.
...
> You may want to explain your scenario, maybe we can come up with a solution together.

I think what I really want to know is the answer to this question.

In a network with topology:

node 1: bat0 bridged to wired lan 0, over wifi batman can see node 2

node 2: bat0 bridged to wired lan 1, over wifi batman can see nodes 1,3

node 3: bat0 bridged to wired lan 1, over wifi batman can see nodes 2,4

node 4: bat0 bridged to wired lan 2, over wifi batman can see node 3

how will packets from wired lan 0 to wired lan 2 make their way
between nodes 2 and 3?  Will Batman be able to use the wired link or
will they just go through wifi?

thanks

donald
