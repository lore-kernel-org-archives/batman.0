Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 4 Sep 2012 09:27:03 +0800
References: <CA+h5VgqWxwCu3M0Y-D+Tuqyx5dj9oiduvvkiL7Op5KVoaac=Lw@mail.gmail.com>
In-Reply-To: <CA+h5VgqWxwCu3M0Y-D+Tuqyx5dj9oiduvvkiL7Op5KVoaac=Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201209040927.04139.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] best way to piggy back data on OGM in batmand
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

On Tuesday, September 04, 2012 06:00:11 Dominic Follett-Smith wrote:
> Could anyone point me in the best direction for how to include some
> extra information in the OGM packet without increasing its size?
> 
> Say for instance I want to send a specific value in the range [0:100]
> along with the OGM.

You wish to append additional data without increasing the size of the OGM ? I 
don't see how this would be possible unless we sent useless data with OGM 
today which you could replace with useful data. That is not the case.

Regards,
Marek
