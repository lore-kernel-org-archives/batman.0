Return-Path: <tobias@hachmer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Jul 2014 13:04:32 +0200
From: Tobias Hachmer <tobias@hachmer.de>
In-Reply-To: <1406281919-25318-1-git-send-email-sven@narfation.org>
References: <1406281919-25318-1-git-send-email-sven@narfation.org>
Message-ID: <3159eb3b9966f4b4b4a3c8ae11217a71@hachmer.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Make unix socket path
	configurable
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

Hello Sven,

On 25.07.2014 11:51, Sven Eckelmann wrote:
> The path to the socket used for client-server communication is 
> currently
> hardcoded in alfred and its complimentary daemons. This makes it hard 
> to run
> two instances of alfred on the same machine without any kind of 
> virtualization
> or containers.
> 
> An user may still want to use two alfred instances to create a test 
> setup or
> connect a single machine two separated alfred data clouds without 
> exchanging
> data between them.

Many thanks for writing the patch! Looking forward to test this...

Regards,
Tobias
