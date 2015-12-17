# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pdjamei <pdjamei@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2014/03/27 19:17:42 by pdjamei           #+#    #+#              #
#    Updated: 2015/06/18 16:02:58 by pdjamei          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME =			test


SOURCES =	test.ml


CAMLC = ocamlc
CAMLCOPT = ocamlcopt
CAMLCDEP = ocamlcdep

LIBS =		$(WITHGRAPHICS)
WITHGRAPHICS = graphics.cma -cclib -lGraphics

FLAG =		-I -Wall -Wextra -Werror -g

RED = \033[33;31m
BLUE = \033[33;34m
GREEN = \033[33;32m
RESET = \033[0m

all: depend $(NAME)

$(NAME): opt byt
		@lb -s $(NAME).byt $(NAME)


opt: $(NAME).opt
byt: $(NAME).byt

OBJS = $(SOURCES:.ml=.cmo)
OPTOBJS = $(SOURCES:.ml=.cmx)

$(NAME).byt: $(OBJS)
		@$(CAMLC) -o $(NAME).byt $(LIBS) $(OBJS)
		@echo "[$(GREEN)Compilation $(BLUE)$(NAME) $(GREEN)ok$(RESET)]"
$(NAME).opt: $(OPTOBJS)
		@$(CAMLCOPT) -o $(NAME).opt $(LIBS:.cma=.cmxa) $(OPTBJS)
		@echo "[$(GREEN)Compilation $(BLUE)$(NAME) $(GREEN)ok$(RESET)]"

.SUFFIXES:
.SUFFIXES: .ml .mli .cmo .cmi .cmx

.ml.cmo:
	$(CAMLC) -c $<

.mli.cmi:
	$(CAMLC) -c $<

.ml.cmx:
	$(CAMLOPT) -c $<

clean:
	@rm -f *.cm[iox] *~ .*~
	@rm -f $(NAME).o
	@echo "[$(RED)Supression des .o et des .cm de $(BLUE)$(NAME) $(GREEN)ok$(RESET)]"

fclean: clean
		@rm -f $(NAME)
		@rm -f $(NAME).opt
		@rm -f $(NAME).byt
		@echo "[$(RED)Supression de $(BLUE)$(NAME) et des .byt et .opt $(GREEN)ok$(RESET)]"

depend : .depend
	$(CAMLDEP) $(SOURCES) > .depend

re: fclean all


include .depend
